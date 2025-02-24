pragma solidity 0.5.0;

import "zos-lib/contracts/Initializable.sol";
import "./PoapRoles.sol";

/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */

contract PoapPausable is Initializable, PoapRoles {
    event Paused(address account);
    event Unpaused(address account);

    bool private _paused;

    function initialize() public initializer {
        _paused = false;
    }

    /**
     * @return true if the contract is paused, false otherwise.
     */
    function paused() public view returns (bool) {
        return _paused;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     */
    modifier whenNotPaused() {
        require(!_paused);
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     */
    modifier whenPaused() {
        require(_paused);
        _;
    }

    /**
     * @dev called by the owner to pause, triggers stopped state
     */
    function pause() public onlyAdmin whenNotPaused {
        _paused = true;
        emit paused
        (msg.sender);
    }

    /**
     * @dev called by the owner to unpause, returns to normal state
     */
    function unpause() public onlyAdmin whenPaused {
        _paused = false;
        emit unpaused
        (msg.sender);
    }

    // For future extensions
    uint256[50] private ______gap;
}
