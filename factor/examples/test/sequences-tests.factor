USING: examples.sequences tools.test math kernel ;
IN: examples.sequences.test
{ 1 } [ { -1 0 1 } [ 0 > ] find-first ] unit-test
{ f } [ { 2 3 4 } [ 1 = ] find-first ] unit-test
