# TimeService
adding the minutes to the time

Challenge:
Write a module named TimeService, that has 2 classes, an initialize method and can be received configuration params with a block.

Requirements:
Use Ruby, and write production quality code.
Your module name should be TimeService and not inherit from another module.
Must have 2 classes within the module
One class must inherit from the other
One class must have an initialize method
Must be able to initialize with a block
Within the subclass write a method that accepts two mandatory arguments and returns a result.

Requirements:
Your function or method should not use any date/time library.
The first argument is a time value in the form of a string with the following format: [H]H:MM {AM|PM}.
The second argument is the number of minutes, as an integer value.
The return value of the function should be a string of the same format as the first argument, which is a result of adding the minutes to the time.
For example
add_minutes('9:13 AM', 10) would return 9:23 AM.
