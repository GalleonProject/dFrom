// web3.js v1.0 is required;
const { getWeb3, getContractInstance } = require("../helpers");
const web3 = getWeb3();
const getInstance = getContractInstance(web3);

const Form = getInstance("Form");

contract("Form", accounts => {
  it("send application", async () => {
    await Form.methods
      .sendApplication("Hi there", "alis@galleon.network")
      .send({ from: accounts[0], gas: 6000000 });
    let applicationsCount = await Form.methods.applicationsCount().call();

    assert(applicationsCount == 1, "The registration wouldn't be completed.");
  });

  it("get my application", async () => {
    await Form.methods
      .sendApplication("Hi there", "bob@galleon.network")
      .send({ from: accounts[1], gas: 6000000 });
    let myApplication = await Form.methods
      .getMyApplication()
      .call({ from: accounts[1] });

    console.log("Registered Application", myApplication);
    assert(
      myApplication[0] == "Hi there",
      "The registration wouldn't be completed."
    );
  });
});
