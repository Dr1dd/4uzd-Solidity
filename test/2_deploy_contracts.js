module.exports = function(deployer) {
    deployer.deploy(artifacts.require('HelloWorld'));
    // Additional contracts can be deployed here
};