import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const  FreelancerPaymentModule = buildModule("FreelancerPayment", (m) => {

    const freelance = m.contract("FreelancerPayment");

    return { freelance };
});

export default  FreelancerPaymentModule;
// 0x21Ff5716440728650a860427dc62782dB1d5b818