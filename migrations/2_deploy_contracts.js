const Housing = artifacts.require('Housing');
module.exports = function(deployer) {
    deployer.deploy(Housing);
    // Additional contracts can be deployed here
};