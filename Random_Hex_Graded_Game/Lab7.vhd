library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity Lab7 is
	port(CLK_50MHz, but, sw3, sw2, sw1, sw0 : in std_logic;
		LEDRand, LEDGrade : out std_logic_vector(0 to 6));
end Lab7;

architecture Logic of Lab7  is
signal counter : std_logic_vector(30 downto 0);
signal rand_value : std_logic_vector(3 downto 0);
signal randi : std_logic_vector(3 downto 0);
signal reset : std_logic;
signal switch : std_logic;

begin
rand: process(CLK_50MHz)
begin
if rising_edge(CLK_50MHz) then
randi <= randi+1;
end if;
end process rand;

push: process (but, CLK_50MHz)
begin 
	
	if (but = '0') then
		rand_value <= randi;
		reset <= '1';
		
		if(rand_value = "0000") then
			LEDRand <= (6 => '1', others => '0');
			
		elsif(rand_value = "0001") then
			LEDRand <= (1 to 2 => '0', others => '1');
			
		elsif(rand_value = "0010") then
			LEDRand <= (2 => '1', 5 => '1', others => '0');
			
		elsif(rand_value = "0011") then
			LEDRand <= (4 to 5 => '1', others => '0');
			
		elsif(rand_value = "0100") then
			LEDRand <= (0 => '1', 3 to 4 => '1', others => '0');
			
		elsif(rand_value = "0101") then
			LEDRand <= (1 => '1', 4 => '1', others => '0');
			
		elsif(rand_value = "0110") then
			LEDRand <= (1 => '1', others => '0');
			
		elsif(rand_value = "0111") then
			LEDRand <= (0 to 2 => '0', others => '1');
			
		elsif(rand_value = "1000") then
			LEDRand <= (others => '0');
			
		elsif(rand_value = "1001") then
			LEDRand <= (4 => '1', others => '0');
			
		elsif(rand_value = "1010") then
			LEDRand <= (3 => '1', others => '0');
			
		elsif(rand_value = "1011") then
			LEDRand <= (0 to 1 => '1', others => '0');
			
		elsif(rand_value = "1100") then
			LEDRand <= (1 to 2 => '1', 6 => '1', others => '0');
			
		elsif(rand_value = "1101") then
			LEDRand <= (0 => '1', 5 => '1', others => '0');
			
		elsif(rand_value = "1110") then
			LEDRand <= (1 to 2 => '1', others => '0');
			
		else
			LEDRand <= (1 to 3 => '1', others => '0');
			
		end if; --ENDS THE LEDRand DEFINITION
	
	elsif rising_edge(CLK_50MHz) then
		if(reset = '1') then
			counter <= (others => '0');
			reset <= '0';
		elsif(counter < "10001111000011010001100000001" and switch = '0') then
			counter <= counter + 1;
		end if;
	end if; --ENDS BUTTON PUSH AND CLOCK INCREMENT
	end process push;
	
	swcomp: process(sw3,sw2,sw1,sw0)
	begin
	if((sw3&sw2&sw1&sw0) = rand_value) then
		switch <= '1';
	else
		switch <= '0';
	end if;
	
	
	if (switch = '1') then
		if(counter < "101111101011110000100000001") then --less than or equal to 2 seconds for an A
			LEDGrade <= (3 => '1', others => '0');
		elsif(counter > "101111101011110000100000000" and counter < "1000111100001101000110000001") then --(2,3] seconds for an B
			LEDGrade <= (0 to 1 => '1', others => '0');
		elsif(counter > "1000111100001101000110000000" and counter < "1011111010111100001000000001") then --(3,4] seconds for a C
			LEDGrade <= (1 to 2 => '1', 6 => '1', others => '0');
		elsif(counter > "1011111010111100001000000000" and counter < "1110111001101011001010000001") then --(4,5] seconds for a D
			LEDGrade <= (0 => '1', 5 => '1', others => '0');
		elsif(counter > "1110111001101011001010000000" and counter < "10001111000011010001100000001") then --(5,6] seconds for a F
			LEDGrade <= (1 to 3 => '1', others => '0');
		end if; --ENDS LEDGrade DEFINTION
	else
		LEDGrade <= "1111111";
		end if; --ENDS USER'S INPUT GRADE
end process swcomp;
end Logic;