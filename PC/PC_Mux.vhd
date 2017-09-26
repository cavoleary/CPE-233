----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2017 04:49:18 PM
-- Design Name: 
-- Module Name: PC_Mux - Behavioral
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

entity PC_Mux is
    Port ( i_From_Immed : in STD_LOGIC_VECTOR (9 downto 0);
           i_From_Stack : in STD_LOGIC_VECTOR (9 downto 0);
           --i_Num        : in STD_LOGIC_Vector (9 downto 0);
           i_Mux_Sel    : in STD_LOGIC_VECTOR (1 downto 0);
           o_Din          : out STD_LOGIC_VECTOR (9 downto 0));
end PC_Mux;

architecture Behavioral of PC_Mux is

signal w_MuxNum : std_logic_vector (9 downto 0);

begin

process (i_Mux_Sel)
begin
    if (i_Mux_Sel = "00") then
        w_MuxNum <= i_From_Immed;
    elsif (i_Mux_Sel = "01") then
        w_MuxNum <= i_From_Stack;
    elsif (i_Mux_Sel = "10") then
        w_MuxNum <= "1111111111";
    end if;
end process; 
o_Din <= w_MuxNum;
end Behavioral;
