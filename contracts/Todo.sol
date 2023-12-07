// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract TodoDapp {
    enum TodoStatus {
        Pending,
        InProgress,
        Completed,
        Cancelled
    }
    enum TodoPriority {
        High,
        Medium,
        Low
    }

    // todo structure with all the fields required
    struct Todo {
        uint256 id;
        string title;
        string description;
        TodoPriority priority;
        string created_at;
        string updated_at;
        TodoStatus status;
    }

    // array of todos
    Todo[] internal todos;
    // count of todos
    uint256 public TodoCount;

    // create todo function
    function createTodo(
        string memory _title,
        string memory _description,
        string memory _priority,
        string memory _created_at,
        string memory _updated_at,
        string memory _status
    ) public {
        // convert strings to enum
        TodoStatus status = stringToEnum(_status);
        TodoPriority priority = stringToPriority(_priority);

        // push todo to array
        todos.push(
            Todo(
                TodoCount,
                _title,
                _description,
                priority,
                _created_at,
                _updated_at,
                status
            )
        );
        // increment todo count
        TodoCount++;
    }

    // find todo by id
    function findTodo(uint256 _id) internal view returns (uint256 todoCounter) {
        for (todoCounter = 0; todoCounter <= todos.length; ) {
            if (todos[todoCounter].id == _id) {
                return todoCounter;
            }
            todoCounter++;
            revert("Todo not found!");
        }
    }

    // update todo function
    function updateTodo(
        uint256 _id,
        string memory _title,
        string memory _description,
        string memory _priority,
        string memory _created_at,
        string memory _updated_at,
        string memory _status
    ) public {
        uint256 todoId = findTodo(_id);

        // convert strings to enum
        TodoStatus status = stringToEnum(_status);
        TodoPriority priority = stringToPriority(_priority);

        // update vlaues
        todos[todoId].title = _title;
        todos[todoId].description = _description;
        todos[todoId].priority = priority;
        todos[todoId].created_at = _created_at;
        todos[todoId].updated_at = _updated_at;
        todos[todoId].status = status;
    }

    // get todo by id
    function showTodo(uint256 _id)
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        uint256 todoId = findTodo(_id);

        string memory priority = priorityToString(todos[todoId].priority);
        string memory status = statusToString(todos[todoId].status);
        return (
            todos[todoId].id,
            todos[todoId].title,
            todos[todoId].description,
            priority,
            todos[todoId].created_at,
            todos[todoId].updated_at,
            status
        );
    }

    // delete todo by id
    function destroyTodo(uint256 _id) public {
        uint256 todoId = _id;
        // delete todo from array by id
        delete todos[todoId];
        TodoCount--;
    }

    // get count of todos based on status provided
    function getTodoCount(string memory _status) public view returns (uint256) {
        uint256 count = 0;
        TodoStatus status = stringToEnum(_status);
        for (uint256 i = 0; i < todos.length; i++) {
            if (todos[i].status == status) {
                count++;
            }
        }
        return count;
    }

    // helpers
    function stringToEnum(string memory _status)
        internal
        pure
        returns (TodoStatus)
    {
        if (
            keccak256(abi.encodePacked(_status)) ==
            keccak256(abi.encodePacked("Pending"))
        ) {
            return TodoStatus.Pending;
        } else if (
            keccak256(abi.encodePacked(_status)) ==
            keccak256(abi.encodePacked("InProgress"))
        ) {
            return TodoStatus.InProgress;
        } else if (
            keccak256(abi.encodePacked(_status)) ==
            keccak256(abi.encodePacked("Completed"))
        ) {
            return TodoStatus.Completed;
        } else if (
            keccak256(abi.encodePacked(_status)) ==
            keccak256(abi.encodePacked("Cancelled"))
        ) {
            return TodoStatus.Cancelled;
        } else {
            revert("Invalid status value");
        }
    }

    function stringToPriority(string memory _priority)
        internal
        pure
        returns (TodoPriority)
    {
        if (
            keccak256(abi.encodePacked(_priority)) ==
            keccak256(abi.encodePacked("High"))
        ) {
            return TodoPriority.High;
        } else if (
            keccak256(abi.encodePacked(_priority)) ==
            keccak256(abi.encodePacked("Medium"))
        ) {
            return TodoPriority.Medium;
        } else if (
            keccak256(abi.encodePacked(_priority)) ==
            keccak256(abi.encodePacked("Low"))
        ) {
            return TodoPriority.Low;
        } else {
            revert("Invalid priority value");
        }
    }

    function priorityToString(TodoPriority _priority)
        internal
        pure
        returns (string memory)
    {
        if (_priority == TodoPriority.High) {
            return "High";
        } else if (_priority == TodoPriority.Medium) {
            return "Medium";
        } else if (_priority == TodoPriority.Low) {
            return "Low";
        } else {
            revert("Invalid priority value");
        }
    }

    function statusToString(TodoStatus _status)
        internal
        pure
        returns (string memory)
    {
        if (_status == TodoStatus.Pending) {
            return "Pending";
        } else if (_status == TodoStatus.InProgress) {
            return "InProgress";
        } else if (_status == TodoStatus.Completed) {
            return "Completed";
        } else if (_status == TodoStatus.Cancelled) {
            return "Cancelled";
        } else {
            revert("Invalid status value");
        }
    }
}
