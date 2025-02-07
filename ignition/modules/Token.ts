import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { parseEther } from "ethers";

export default buildModule("BEESavingModule", (m) => {
    const initialSupply = parseEther("1000000"); 

    const beeSaving = m.contract("BEESaving", [initialSupply]);

    return { beeSaving };
});
