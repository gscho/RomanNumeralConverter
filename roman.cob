identification division.
program-id. romannumerals.
environment division.
input-output section.
file-control.
    select standard-input assign to keyboard.
    select standard-output assign to display.
	select infile assign to fin-r organization is line sequential.
data division.
file section.
fd standard-input.
    01 stdin-record   picture x(80).
fd standard-output.
    01 stdout-record  picture x(80).
working-storage section.
77  n    picture s99 usage is computational. *> Used for iteration
77  temp picture s9(8) usage is computational.
77  i 	 picture s9. *> Used for iteration
77  choice 	 picture s9.
77  ws-count  picture 9(2) value 0. *> Used for counting characters
77  ws-spaces  picture 9(2) value 0. *> Used for counting spaces
01  array-area.
    02 r picture x(9) occurs 30 times.
01  farray-area.
    02 fr picture x(9) occurs 30 times.
01  input-area.
    02 in-r   picture x(9).
    02 filler picture x(79).
01  finput-area.
    02 fin-r   picture x(9).
    02 filler picture x(79).
01	option-area.
	02 opt-r  picture x.
01  title-line.
    02 filler picture x(11) value spaces.
    02 filler picture x(24) value 'roman number equivalents'.
01  underline-1.
    02 filler picture x(45) value 
       ' --------------------------------------------'.
01  col-heads.
    02 filler picture x(9) value spaces.
    02 filler picture x(12) value 'roman number'.
    02 filler picture x(13) value spaces.
    02 filler picture x(11) value 'dec. equiv.'.
01  underline-2.
    02 filler picture x(45) value
       ' ------------------------------   -----------'.  
01  print-line.
    02 filler picture x value space.
    02 out-r  picture x(30).
    02 filler picture x(3) value spaces.
    02 out-eq picture z(9).
	02 out-eq2 picture z(9).
	
procedure division.
    
    open input standard-input, output standard-output.
    perform usr-prompt thru end-usrprompt
		until choice is greater than 0.
		
usr-prompt.	*> Used for determining if the user wants to read from STDIN or a file
	if choice equals 1 or choice equals 2
		exit paragraph.
	display 'Choose input method:' 
    display '1.STDIN' 
    display '2.File'
    display 'q = quit' 
    display space end-display.
    read standard-input into option-area.
	evaluate option-area
		when 1 move 1 to choice
		when 2 move 2 to choice
		when 'q' stop run
		when other display 'Invalid entry'.
end-usrprompt.

	evaluate choice
		when 1 perform romangui thru end-romangui
		when 2 perform file-name thru end-filename.
						
romangui. *> Used for displaying the roman numeral and the decimal equivalent
	write stdout-record from title-line after advancing 1 lines.
    write stdout-record from underline-1 after advancing 1 line.
    write stdout-record from col-heads after advancing 1 line.
    write stdout-record from underline-2 after advancing 1 line.
    display space end-display.
end-romangui.

	perform loop1 thru end-loop1 until in-r is equal to 'q'.


		
loop1.  *> Loop 1 is for reading numerals from stdin

    move 1 to n. move spaces to array-area.move 0 to ws-count.move 0 to ws-spaces. *>initializing the variables.
	read standard-input into input-area.
    move in-r to r(n).
    if r(1) is equal to 'q'
		stop run.
    inspect in-r tallying ws-count for all characters.
    inspect in-r tallying ws-spaces for all spaces.
    subtract ws-spaces from ws-count.
    move ws-count to n.
    call "conv" using array-area, n, temp.
	move temp to out-eq. move array-area to out-r.
    write stdout-record from print-line after advancing 1 line.
    display space.
    
end-loop1.

file-name.
	display 'Enter the file name: '
	read standard-input into finput-area
	move fin-r to fr(n)
	if fr(1) is equal to 'q' and fr(2) is equal to space
		stop run.
	open input infile.			
end-filename.

	perform loop2 thru end-loop2 until fin-r is equal to 'q'.
	
loop2.	*> Loop2 is for reading numerals from a file
	move 1 to n. move spaces to array-area.move 0 to ws-count.move 0 to ws-spaces.
	move spaces to farray-area.
	read infile into finput-area
		at end close infile perform file-name thru end-filename.
	move fin-r to fr(n).
	inspect fin-r tallying ws-count for all characters.
	inspect fin-r tallying ws-spaces for all spaces.
    subtract ws-spaces from ws-count.
    move ws-count to n.
	call "conv" using farray-area, n, temp.
	move temp to out-eq. move array-area to out-r.
	move fin-r to out-eq2.
	write stdout-record from title-line after advancing 1 lines.
    write stdout-record from underline-1 after advancing 1 line.
    write stdout-record from col-heads after advancing 1 line.
    write stdout-record from underline-2 after advancing 1 line.
    display space.
    display fin-r.
    write stdout-record from print-line after advancing 0 line.
    display space.
end-loop2.
