----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2017 04:49:18 PM
-- Design Name: 
-- Module Name: PC - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( i_Din : in STD_LOGIC_VECTOR (9 downto 0);
           i_PC_LD : in STD_LOGIC;
           i_PC_Inc : in STD_LOGIC;
           i_RST : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           o_PC_Count : out STD_LOGIC_VECTOR (9 downto 0));
end PC;

architecture Behavioral of PC is

signal PC_Count : std_logic_vector (9 downto 0) := "0000000000";

begin
process (i_clk)
begin
    if rising_edge(i_clk) then
        if (i_RST = '1') then
            PC_Count <= "0000000000";
        elsif (i_PC_LD = '1') then
            PC_Count <= i_Din;
        elsif (i_PC_Inc = '1') then
            PC_Count <= PC_Count + 1; 
        end if;
    end if; 
end process;
o_PC_Count <= PC_Count; 
end Behavioral;
