--1
--A View is a virtual table that contains data from one or multiple tables.
--It doesn't hold any data and is not stored physically in database.
--Any changes made in view will be reflected in real table.
--1.View can represent a subset of data and limit the degree of exposure to the outer world
--2.We can join multiple tables and aggregate columns.
--3.View only need store the definition not a copy of data.

--2
--Yes. If view contains joins between multiple tables, only one table can be insert or update.
--And no delete rows can be performed.

--3
--Stored procedure is a batch pf statements grouped as a logical unit and stored in database.
--1.It can be easily modified.
--2.Reduce network traffic. Only procedure name is passed over the network.
--3.Reusable.
--4.Security. Elimate direct access to the table.
--5.Performance. Execution plan will be stored in buffer pool and can be reused.

--4
/*
A SQL View is a virtual table, which is based on SQL SELECT query. A view references one or more existing database tables or other views. It is the snapshot of the database 
whereas a stored procedure is a group of Transact-SQL statements compiled into a single execution plan.
View is simple showcasing data stored in the database tables whereas a stored procedure is a group of statements that can be executed.
A view is faster as it displays data from the tables referenced whereas a store procedure executes sql statements.
*/

--5
/*
Function must return a value but in Stored Procedure it is optional.
Functions can have only input parameters for it whereas Procedures can have input/output parameters.
Function takes one input parameter it is mandatory but Stored Procedure may take 0 to n input parameters.
Functions can be called from Procedure whereas Procedures cannot be called from Function.
*/

--6
--Most stored procedures return multiple result sets. Such a stored procedure usually includes one or more select statements. We need to consider this inclusion to handle all the result sets.

--7
--No, we should use function instead. Stored procedure are intended for executing by an outside program or on a timed interval

--8
--It is a special stored procedure executed automatically in response to database or server events.
--Three types: DML, DDL and logon triggers

--9
--Auditing and enforcing business rules
--Writing a log automatically on changes
--Enforce data integrity -> when buying something, deduct stock across tables

--10
--1. Trigger executes automatically on specified events, can not be explicitly executed
--2. Trigger can not take input parameter
--3. Can't use transaction staments inside trigger
--4. Trigger can't return values


--1

