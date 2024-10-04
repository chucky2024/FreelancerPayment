// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract FreelancerPayment {
    struct Project {
        address freelancer;
        string description;
        uint256 payment;
        uint256 milestonesCompleted;
    }

    mapping(bytes32 => Project) public projects;

    event ProjectCreated(bytes32 indexed projectId, address indexed freelancer, string description, uint256 payment);
    event PaymentReleased(bytes32 indexed projectId, uint256 amount);

    function createProject(bytes32 projectId, address freelancer, string memory description, uint256 payment) public {
        projects[projectId] = Project(freelancer, description, payment, 0);
        emit ProjectCreated(projectId, freelancer, description, payment);
    }

    function completeMilestone(bytes32 projectId) public {
        Project storage project = projects[projectId];
        require(msg.sender == project.freelancer, "Only freelancer can complete milestones");
        project.milestonesCompleted++;
    }

    function releasePayment(bytes32 projectId) public {
        Project storage project = projects[projectId];
        require(msg.sender == project.freelancer, "Only freelancer can request payment");
        require(project.milestonesCompleted > 0, "No milestones completed");

        uint256 amountToPay = project.payment / project.milestonesCompleted;
        payable(project.freelancer).transfer(amountToPay);
        emit PaymentReleased(projectId, amountToPay);
    }
}
