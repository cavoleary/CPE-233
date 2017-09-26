----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2017 08:52:25 PM
-- Design Name: 
-- Module Name: PC_Wrapper - Behavioral
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

entity PC_Wrapper is
    Port ( i_From_Stack : in STD_LOGIC_VECTOR (9 downto 0);
           i_From_Immed : in STD_LOGIC_VECTOR (9 downto 0);
           i_Mux_Sel : in STD_LOGIC_VECTOR (1 downto 0);
           i_PC_LD : in STD_LOGIC;
           i_PC_Inc : in STD_LOGIC;
           i_RST : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           o_PC_Count : out STD_LOGIC_VECTOR (9 downto 0));
end PC_Wrapper;

architecture Behavioral of PC_Wrapper is
    component PC_Mux is
      Port ( i_From_Immed         : in std_logic_vector (9 downto 0);
             i_From_Stack         : in std_logic_vector (9 downto 0);
             i_Mux_Sel            : in std_logic_vector (1 downto 0);
             
             o_Din               : out std_logic_vector (9 downto 0));
   end component;
 
   component PC is
      Port ( i_Din                : in std_logic_vector (9 downto 0);
             i_PC_LD              : in std_logic;
             i_PC_INC             : in std_logic;
             i_RST                : in std_logic;
             i_clk                : in std_logic;
         
             o_PC_COUNT           : out std_logic_vector (9 downto 0));
      end component;

signal D_MUX_TO_PC : std_logic_vector (9 downto 0);
signal PC_ADDRESS  : std_logic_vector (9 downto 0);
     
begin
PC_MUX_C: PC_MUX port map (      i_FROM_STACK       =>     i_FROM_STACK,
                                 i_FROM_IMMED       =>     i_FROM_IMMED,
                                 i_Mux_Sel         =>     i_Mux_Sel,
                                 o_Din            =>     D_MUX_TO_PC);
                                 
ProgramCounter: PC port map (    i_clk              =>     i_clk,
                                 i_DIN              =>     D_MUX_TO_PC,
                                 i_PC_LD            =>     i_PC_LD,
                                 i_PC_INC           =>     i_PC_INC,
                                 i_RST              =>     i_RST,
                                 o_PC_COUNT         =>     PC_ADDRESS);

end Behavioral;
