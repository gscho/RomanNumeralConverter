identification division.
program-id. conv.
environment division.
input-output section.
file-control.
    select standard-output assign to display.

data division.
file section.
fd standard-output.
    01 stdout-record  picture x(80).

working-storage section.
77  i    picture s99 usage is computational.
77  prev picture s9(8) usage is computational.
77  curr picture s9(8) usage is computational.
01 error-mess.
    02 filler picture x(22) value ' illegal roman numeral'.

linkage section.
77  m    picture s99 usage is computational.
77  sum1 picture s9(8) usage is computational.
01  array-area.
    02 s picture x(1) occurs 30 times.

procedure division using array-area, m, sum1.
    move zero to sum1. move zero to curr. move zero to prev.
    perform loop thru end-loop varying i from 1 by 1
       until i is greater than m.
	   goback.
loop.
	evaluate s(i)
		when 'I' move 1 to curr
		when 'i' move 1 to curr
		when 'V' move 5 to curr
		when 'v' move 5 to curr
		when 'X' move 10 to curr
		when 'x' move 10 to curr
		when 'L' move 50 to curr
		when 'l' move 50 to curr
		when 'C' move 100 to curr
		when 'c' move 100 to curr
		when 'D' move 500 to curr
		when 'd' move 500 to curr
		when 'M' move 1000 to curr
		when 'm' move 1000 to curr
		when other perform err-mess.
	if curr is greater than prev
		compute sum1 = sum1 + (curr - prev *2)
	else
		add curr to sum1.
	move curr to prev.
end-loop. 
err-mess. open output standard-output.
    write stdout-record from error-mess after advancing 1 line.
    display space.
    move zero to curr.close standard-output.
    goback.
