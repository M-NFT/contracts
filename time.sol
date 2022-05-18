// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract contract1  {


    uint64 public timeStart;

    constructor() { //uint64 _timeStart

        // timeStart = _timeStart;

    }

    uint32 public blockTimestamp = uint32(block.timestamp % 2**32);

    uint64 public blockTimestamp2 = uint64(block.timestamp);
    // uint64 public blockTimestamp2 = uint64(now);

    uint256 public fds = 2**32;
    uint256 public fds2 = 800%60;
    uint256 public fds3 = 801%60;
    // time public dffs = now;
    
    function fdsf () public view returns (uint256) {
        return block.timestamp;
    }    


    // function fdsf2 () public view returns (uint256) {
    //     return now;
    // }       
}