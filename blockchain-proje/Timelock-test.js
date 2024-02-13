const{expect} = require('chai');
const { ethers, network } = require('hardhat');
const provider = ethers.provider;

const TOKEN_ADDRESS = "0xc7AD46e0b8a400Bb3C915120d284AafbA8fc4735";

const TONE_ABI = [
    "function transfer(address to, uint256 amount) retuns(bool)",
    "function approve(address spender, uint256 amount) retuns(bool)",
    "function balanceOf(address owner) view retuns(uint256)",
];

function ethToNum(val){
    return Number(ethers.utils.formatEther(val));
}

async function getBlockTimestamp() {
    let block_number, block, block_timestamp;

    block_number = await provider.getBlockNumber();;
    block = await provider.getBlock(block_number);
    block_timestamp = block.timestamp;

    return block_timestamp;
}

async function increaseTime(value) {
    await provider.send('evm_increaseTime', [value]);
    await provider.send('evm_mine');
}

describe("Timelock" , function(){

    let owner, user;
    let userBalance;
    let Lock, lock;
    let token;

    // her testen sonra o anın timestampına erişmek için , diğeri başlagıçta bir chechpoint atayıp sonrasında test
    // aşamalarında istediğimiz zamanda atamalar yapabilmek için.
    let timestamp, initialTimestamp;

    before(async function(){

        await hre.network.provider.request({
            method: "hardhat_impersonateAccount",
            params: ["0x770dE306a8E54b31d4eA18AA5aBf3Da1ef571A6C"],
        });
    
        owner = await ethers.getSigner("0x770dE306a8E54b31d4eA18AA5aBf3Da1ef571A6C");

        owner = await ethers.getSigner("0x770dE306a8E54b31d4eA18AA5aBf3Da1ef571A6C");
        [user] = await ethers.getSigner();

        token = new ethers.Contract(TOKEN_ADDRESS, TOKEN_ABI, provider);

        Lock = await ethers.getContractFactory("Lock");
        lock = await Lock.connect(owner).deploy(token.address); 

        token.connect(owner).transfer(user.address,ethers.utils.parseUnits("100",18));
        token.connect(user).approve(lock.address, ethers.constants.MaxInt256);

        //Automine özelliğini kapadık
        await network.provider.send("evm_setAutomine", [false]);

        initialTimestamp = await getBlockTimestamp();
        await provider.send('evm_setNextBlockTimestamp', [initialTimestamp + 1]);
        await provider.send('evm_mine');
        

    });

    beforeEach(async function(){
        userBalance = await ethToNum(await token.balanceOf(user.address));
        timestamp = await getBlockTimestamp();
    });

    it("Forks", async function(){

        expect(owner.address).to.be.properAddress;
        expect(user.address).to.be.properAddress;
        expect(token.address).to.be.properAddress;
        expect(lock.address).to.be.properAddress;
        

    });

    it("Funds user", async function(){

        expect(userBalance).to.be.greaterThan(0);

    });

    describe("Contract Interarction ", function(){

        it("t = 2 - Locks for 5 seconds ",async function(){
            await provider.send('evm_setNextBlockTimestamp', [initialTimestamp + 2]);
            await lock.connect(user).lockTokens(ethers.utils.parseEther("10"),"5");
            await provider.send("evm_mine");
        });

        it("t > 7 - Can withdraw", async function(){
            await provider.send('evm_setNextBlockTimestamp', [initialTimestamp + 8]);

            await lock.connect(user).withdrawTokens();
            await provider.send("evm_mine");

            let newBalance = ethToNum(await token.balanceOf(user.address));

            expect(newBalance).to.be.equal(userBalance + 10);
        });
        
        // Automine işlemi
        it("Skips time", async function(){
            await network.provider.send("evm_setAutomine", [true]);
            await increaseTime(1000);

            let newTimestamp = await getBlockTimestamp();

            expect(newTimestamp).to.be.greaterThan(timestamp);
            console.log("timestamp -> ", timestamp, newTimestamp);
        });
    });

});