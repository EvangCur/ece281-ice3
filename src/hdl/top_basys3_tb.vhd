--+----------------------------------------------------------------------------
--| 
--| COPYRIGHT 2017 United States Air Force Academy All rights reserved.
--| 
--| United States Air Force Academy     __  _______ ___    _________ 
--| Dept of Electrical &               / / / / ___//   |  / ____/   |
--| Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
--| 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
--| USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
--| 
--| ---------------------------------------------------------------------------
--|
--| FILENAME      : top_basys3_tb.vhd
--| AUTHOR(S)     : Capt Johnson
--| CREATED       : 01/30/2019 Last Modified 06/24/2020
--| DESCRIPTION   : This file implements a test bench for the full adder top level design.
--|
--| DOCUMENTATION : None
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : top_basys3.vhd
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity top_basys3_tb is
port(
    sw		:	in  std_logic_vector(2 downto 0);
		
		-- LEDs
    led	    :	out	std_logic_vector(1 downto 0)
);
end top_basys3_tb;

architecture test_bench of top_basys3_tb is 
	
  -- declare the component of your top-level design unit under test (UUT)
  component halfAdder is
    port (
        i_A : in std_logic;
        i_B : in std_logic;
        o_S : out std_logic;
        o_C : out std_logic
        );
    end component halfAdder;

  
 
	-- declare signals needed to stimulate the UUT inputs
    signal w_sw2 : std_logic := '0'; -- Carry in    
    signal w_sw1 : std_logic := '0'; -- A
    signal w_sw0 : std_logic := '0'; -- B
    signal w_led1 : std_logic := '0'; -- Carry out
    signal w_led0 : std_logic := '0'; -- Sum
    signal w_S1 : std_logic := '0'; -- Sum1 out
    signal w_C1 : std_logic := '0'; -- Carry out 1
    signal w_C2 : std_logic := '0'; -- Carry out 2

	-- finish declaring needed signals
begin
	-- PORT MAPS ----------------------------------------
	-- You must create the port map for your top_basys3.
	-- Look at your old test benches if you are unsure what to do
	-----------------------------------------------------
	halfAdder_inst1 : halfAdder port map (
	    i_A  => w_sw0, -- notice comma (not a semicolon)
        i_B  => w_sw1,
        o_S  => w_S1,
        o_C  => w_C1
	);
	halfAdder_inst2 : halfAdder port map (
        i_A  => w_S1,
        i_B  => w_sw2,
        o_S  => w_led0,
        o_C  => w_C2
        );
	-- PROCESSES ----------------------------------------	
	-- Test Plan Process
	-- Implement the test plan here.  Body of process is continuously from time = 0  
	test_process : process 
	begin
	
	    w_sw0 <= '1'; w_sw1 <= '0'; w_sw2 <= '0'; wait for 10 ns;
		assert w_led0 = '1' report "bad o0" severity failure;
		assert w_led1 = '0' report "bad o0" severity failure;
		wait for 10 ns;
        w_sw0 <= '0'; w_sw1 <= '1'; w_sw2 <= '0'; wait for 10 ns;
        assert w_led0 = '1' report "bad o1" severity failure;
        assert w_led1 = '0' report "bad o1" severity failure;
        wait for 10 ns;
        w_sw0 <= '1'; w_sw1 <= '1'; w_sw2 <= '0'; wait for 10 ns;
        assert w_led0 = '0' report "bad o2" severity failure;
        assert w_led1 = '1' report "bad o2" severity failure; 
        wait for 10 ns;
        w_sw0 <= '0'; w_sw1 <= '0'; w_sw2 <= '1'; wait for 10 ns;
        assert w_led0 = '1' report "bad o3" severity failure;
        assert w_led1 = '0' report "bad o3" severity failure;
        wait for 10 ns;
        w_sw0 <= '1'; w_sw1 <= '0'; w_sw2 <= '1'; wait for 10 ns;
        assert w_led0 = '0' report "bad o4" severity failure;
        assert w_led1 = '1' report "bad o4" severity failure;
        wait for 10 ns;
        w_sw0 <= '0'; w_sw1 <= '1'; w_sw2 <= '1'; wait for 10 ns;
        assert w_led0 = '0' report "bad o5" severity failure;
        assert w_led1 = '1' report "bad o5" severity failure;
        wait for 10 ns;
        w_sw0 <= '1'; w_sw1 <= '1'; w_sw2 <= '1'; wait for 10 ns;
        assert w_led0 = '1' report "bad o6" severity failure;
        assert w_led1 = '1' report "bad o6" severity failure;
	    --You must fill in the remaining test cases.	
	
		wait; -- wait forever
	end process;	
	-----------------------------------------------------	
	
end test_bench;
