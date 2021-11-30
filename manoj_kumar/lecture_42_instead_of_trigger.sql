/*
Instead of trigger

This trigger is used on view instead of Tables

View types:
    *   Simple View:- This is based on a single table.
    *   Compound view: This consists of more than one table.

Requirement/necessity:
    *   It is fine when view is on one table only (Simple view) however when view conisists of various tables then while performing trigger 
        operations, it gets confused what table we haev to update/delete etc.
    *   In such case instead of trigger comes into play..
    *   We mention the table names in trigger when/what to update, what values to give etc.
    *   If we try to update compound view without mentioning 'Instead of' it will give below error:
            'cannot modify more than one base table'
            
Syntax:
    *   we are already aware of this
*/
    