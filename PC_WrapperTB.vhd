----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2017 09:23:33 PM
-- Design Name: 
-- Module Name: PC_WrapperTB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC_WrapperTB is
--  Port ( );
end PC_WrapperTB;

architecture Behavioral of PC_WrapperTB is

COMPONENT PC_Wrapper
   Port (    i_FROM_STACK          : in std_logic_vector (9 downto 0);
             i_FROM_IMMED          : in std_logic_vector (9 downto 0);
             i_Mux_Sel          : in std_logic_vector (1 downto 0);
             i_PC_LD               : in std_logic;
             i_PC_INC              : in std_logic;
             i_RST                 : in std_logic;
             i_clk              : in std_logic;
             
            o_PC_Count      : out std_logic_vector (9 downto 0));
    END COMPONENT;
   
 
   --Inputs
   signal FROM_IMMED_tb : std_logic_vector(9 downto 0) := "0000010000"; --x010
   signal FROM_STACK_tb : std_logic_vector(9 downto 0) := "0110101010"; --x1AA
   signal INTERRUPT_tb  : std_logic_vector(9 downto 0) := "1111111111"; --x3FF
   signal PC_MUX_SEL_tb : std_logic_vector(1 downto 0) := (others => '0');
   signal PC_OE_tb      : std_logic := '0';
   signal PC_LD_tb      : std_logic := '0';
   signal PC_INC_tb     : std_logic := '0';
   signal RST_tb        : std_logic := '0';
   signal CLK           : std_logic := '0';
 
    --Outputs
   signal D_OUT : std_logic_vector(9 downto 0);
 
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
--     Instantiate the Unit Under Test (UUT)
uut: PC_Wrapper PORT MAP ( i_FROM_IMMED          => FROM_IMMED_tb,
                                    i_FROM_STACK          => FROM_STACK_tb,
                                    i_Mux_Sel          => PC_MUX_SEL_tb,
                                    i_PC_LD               => PC_LD_tb,
                                    i_PC_INC              => PC_INC_tb,
                                    i_RST                 => RST_tb,
                                    i_clk              => CLK,
                                    o_PC_Count     => D_OUT);
 
   -- Clock process definitions
   CLK_process :process
   begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
   end process;
 
 
   -- Stimulus process
   stim_proc: process
   begin      
    --Simulation 1:
        --test PC functions are synch
        --test asynch reset
 
      wait for 10 ns;  
        PC_LD_tb <= '1';
        wait for 5 ns;
        PC_LD_tb <= '0'; --check load is synchronous
        wait for 10 ns;  --PC_COUNT = 0
        PC_LD_tb <= '1';
        wait for 5 ns;   --PC_COUNT = x0CC
        wait for 10 ns;  --PC_TRI = x0CC
        RST_tb <= '1';
        wait for 10 ns;  --PC_COUNT = 0
        wait for 10 ns;
 
       
    --Simulation 2:
        --test MUX selectors
        --test increment
        --test precedence
 
        RST_tb <= '0';
        wait for 10 ns; --PC_COUNT = x0CC
        PC_MUX_SEL_tb <= "10";
        wait for 10 ns; --PC_COUNT = x3FF
        PC_MUX_SEL_tb <= "01";
        wait for 10 ns; --PC_COUNT = x1AA
        PC_LD_tb <= '0';
        PC_INC_tb <= '1';
        wait for 10 ns; --PC_COUNT = x1AB
        PC_LD_tb <= '1';
        wait for 10 ns; --PC_Count = x1AA
       

   
   end process;



end Behavioral;
