/*

Triggers are invoked on tables onlz when we perfrom any type of action on any tables

Total 12 "Types" basically

Statement Level
        BEFORE
                INSERT
                UPDATE
                DELETE
        AFTER
                INSERT
                UPDATE
                DELETE
                
Row Level
        BEFORE
                INSERT
                UPDATE
                DELETE
        AFTER
                INSERT
                UPDATE
                DELETE

Sequence of trigger is:
        Statement level BEFORE --> Row level BEFORE --> Row Level AFTER --> Statement Level AFTER
*/