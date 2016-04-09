--
-- kromcopy.vhd
--
-- MZ-1500 Version Up Adaptor, K-ROM/J-ROM copy module
-- for MZ-1500
--
-- Nibbles Lab. 2016
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity kromcopy is
  port(
	-- Analog input
	AIN           : in    std_logic_vector( 7 downto 0);
	-- D-A Converter
	AD5681R_LDACn : out   std_logic;
	AD5681R_RSTn  : out   std_logic;
	AD5681R_SCL   : out   std_logic;
	AD5681R_SDA   : out   std_logic;
	AD5681R_SYNCn : out   std_logic;
	-- Temperature Sensor
	ADT7420_CT    : in    std_logic;
	ADT7420_INT   : in    std_logic;
	ADT7420_SCL   : out   std_logic;
	ADT7420_SDA   : inout std_logic;
	-- 3-Axis Accelerometer
	ADXL362_CS    : out   std_logic;
	ADXL362_INT1  : in    std_logic;
	ADXL362_INT2  : in    std_logic;
	ADXL362_MISO  : in    std_logic;
	ADXL362_MOSI  : out   std_logic;
	ADXL362_SCLK  : out   std_logic;
	-- GPIO J4
	I2C_SCL       : inout std_logic;
	I2C_SDA       : inout std_logic;
	ZADDR         : in    std_logic_vector(15 downto 0);
	--GPIO_J4_06    : in    std_logic;
	--GPIO_J4_05    : in    std_logic;
	--GPIO_J4_12    : in    std_logic;
	--GPIO_J4_11    : in    std_logic;
	--GPIO_J4_14    : in    std_logic;
	--GPIO_J4_13    : in    std_logic;
	--GPIO_J4_16    : in    std_logic;
	--GPIO_J4_15    : in    std_logic;
	--GPIO_J4_20    : in    std_logic;
	--GPIO_J4_19    : in    std_logic;
	--GPIO_J4_22    : in    std_logic;
	--GPIO_J4_21    : in    std_logic;
	--GPIO_J4_24    : in    std_logic;
	--GPIO_J4_23    : in    std_logic;
	--GPIO_J4_28    : in    std_logic;
	--GPIO_J4_27    : in    std_logic;
	ZDDIR         : out   std_logic;		--GPIO_J4_29
	ZDOE          : out   std_logic;		--GPIO_J4_30
	ZCLK          : in    std_logic;		--GPIO_J4_31;
	PCGSW         : in    std_logic;		--GPIO_J4_32;
	MREQ_x        : in    std_logic;		--GPIO_J4_35;
	IORQ_x        : in    std_logic;		--GPIO_J4_36;
	RD_x          : in    std_logic;		--GPIO_J4_37;
	WR_x          : in    std_logic;		--GPIO_J4_38;
	M1_x          : in    std_logic;		--GPIO_J4_39;
	ZRST          : in    std_logic;		--GPIO_J4_40;
	-- GPIO J5
	AUDIO_L       : out std_logic;		--GPIO_J5_01
	AUDIO_R       : out std_logic;		--GPIO_J5_02
	GPIO_J5_03    : inout std_logic;
	GPIO_J5_04    : inout std_logic;
	QD_M1         : out std_logic;		--GPIO_J5_05
	QD_CLK        : out std_logic;		--GPIO_J5_06
	QD_RST        : out std_logic;		--GPIO_J5_07
	QD_S1         : out std_logic;		--GPIO_J5_08
	GPIO_J5_09    : inout std_logic;
	GPIO_J5_10    : inout std_logic;
	GPIO_J5_13    : inout std_logic;
	GPIO_J5_14    : inout std_logic;
	GPIO_J5_15    : inout std_logic;
	GPIO_J5_16    : inout std_logic;
	GPIO_J5_17    : inout std_logic;
	RGB_VSI       : in std_logic;			--GPIO_J5_18;
	GPIO_J5_19    : inout std_logic;
	RGB_HSI       : in std_logic;			--GPIO_J5_20;
	GPIO_J5_21    : inout std_logic;
	GPIO_J5_22    : inout std_logic;
	GPIO_J5_23    : inout std_logic;
	RGB_BI        : in std_logic;			--GPIO_J5_24;
	GPIO_J5_25    : inout std_logic;
	RGB_GI        : in std_logic;			--GPIO_J5_26;
	GPIO_J5_27    : inout std_logic;
	RGB_RI        : in std_logic;			--GPIO_J5_28;
	GPIO_J5_31    : inout std_logic;
	GPIO_J5_32    : inout std_logic;
	QD_RD         : out std_logic;		--GPIO_J5_33
	QD_IORQ       : out std_logic;		--GPIO_J5_34
	QD_CS         : out std_logic;		--GPIO_J5_35
	QD_S0         : out std_logic;		--GPIO_J5_36
	GPIO_J5_37    : inout std_logic;
	VGA_VSO       : out std_logic;		--GPIO_J5_38
	GPIO_J5_39    : inout std_logic;
	VGA_HSO       : out std_logic;		--GPIO_J5_40
	-- Card Edge
	EG_P1         : inout std_logic;
	EG_P2         : inout std_logic;
	EG_P3         : inout std_logic;
	EG_P4         : inout std_logic;
	EG_P5         : inout std_logic;
	EG_P6         : inout std_logic;
	EG_P7         : inout std_logic;
	EG_P8         : inout std_logic;
	EG_P9         : inout std_logic;
	EG_P10        : inout std_logic;
	EG_P11        : inout std_logic;
	EG_P12        : inout std_logic;
	EG_P13        : inout std_logic;
	EG_P14        : inout std_logic;
	EG_P15        : inout std_logic;
	EG_P16        : inout std_logic;
	EG_P17        : inout std_logic;
	EG_P18        : inout std_logic;
	EG_P19        : inout std_logic;
	EG_P20        : inout std_logic;
	EG_P21        : inout std_logic;
	EG_P22        : inout std_logic;
	EG_P23        : inout std_logic;
	EG_P24        : inout std_logic;
	EG_P25        : inout std_logic;
	EG_P26        : inout std_logic;
	EG_P27        : inout std_logic;
	EG_P28        : inout std_logic;
	EG_P29        : inout std_logic;
	EG_P35        : inout std_logic;
	EG_P36        : inout std_logic;
	EG_P37        : inout std_logic;
	EG_P38        : inout std_logic;
	EG_P39        : inout std_logic;
	EG_P40        : inout std_logic;
	EG_P41        : inout std_logic;
	EG_P42        : inout std_logic;
	EG_P43        : inout std_logic;
	EG_P44        : inout std_logic;
	EG_P45        : inout std_logic;
	EG_P46        : inout std_logic;
	EG_P47        : inout std_logic;
	EG_P48        : inout std_logic;
	EG_P49        : inout std_logic;
	EG_P50        : inout std_logic;
	EG_P51        : inout std_logic;
	EG_P52        : inout std_logic;
	EG_P53        : inout std_logic;
	EG_P54        : inout std_logic;
	EG_P55        : inout std_logic;
	EG_P56        : inout std_logic;
	EG_P57        : inout std_logic;
	EG_P58        : inout std_logic;
	EG_P59        : inout std_logic;
	EG_P60        : inout std_logic;
	EXP_PRESENT   : inout std_logic;
	RESET_EXPn    : inout std_logic;
	-- Serial Flash
	SFLASH_ASDI   : out   std_logic;
	SFLASH_CSn    : out   std_logic;
	SFLASH_DATA   : in    std_logic;
	SFLASH_DCLK   : out   std_logic;
	-- Push Button
	PB            : in    std_logic_vector( 3 downto 0);
	-- Pmod
	INT_x         : out   std_logic;		--PMOD_A(3)
	ZWAIT_x       : out   std_logic;		--PMOD_A(2)
	DOPIO5        : out   std_logic;		--PMOD_A(1)
	DOPIO4        : out   std_logic;		--PMOD_A(0)
	DOEPIO        : out   std_logic;		--PMOD_B(3)
	VGA_BO        : out   std_logic;		--PMOD_B(2)
	VGA_GO        : out   std_logic;		--PMOD_B(1)
	VGA_RO        : out   std_logic;		--PMOD_B(0)
	ZDT           : inout std_logic_vector( 7 downto 0);		--PMOD_C,PMOD_D
	-- SDRAM
	SDRAM_A       : out   std_logic_vector(12 downto 0);
	SDRAM_BA      : out   std_logic_vector( 1 downto 0);
	SDRAM_CASn    : out   std_logic;
	SDRAM_CKE     : out   std_logic;
	SDRAM_CLK     : out   std_logic;
	SDRAM_CSn     : out   std_logic;
	SDRAM_DQMH    : out   std_logic;
	SDRAM_DQML    : out   std_logic;
	SDRAM_DQ      : inout std_logic_vector(15 downto 0);
	SDRAM_RASn    : out   std_logic;
	SDRAM_WEn     : out   std_logic;
	-- Misc.
	SYS_CLK       : in    std_logic;
	USER_CLK      : in    std_logic;
	USER_LED      : out   std_logic_vector( 7 downto 0)
  );
end kromcopy;

architecture rtl of kromcopy is
--
-- MZ-700 System Bus
--
signal ZRST_x : std_logic;
signal ZDTO : std_logic_vector(7 downto 0);
signal ZDTI : std_logic_vector(7 downto 0);
signal ZDDIRi : std_logic;
--
-- Kanji-ROM/Jisho-ROM
--
signal WDAT : std_logic_vector(7 downto 0);
signal WADR : std_logic_vector(7 downto 0);
signal XFADR : std_logic_vector(7 downto 0);
signal FDAT : std_logic_vector(7 downto 0);
signal FADR : std_logic_vector(15 downto 0);
signal SNSWRM : std_logic;
signal ENW : std_logic;
signal FCS : std_logic;
signal BITCNT : std_logic_vector(2 downto 0);
signal BYTECNT : std_logic_vector(8 downto 0);
signal SR_TX : std_logic_vector(7 downto 0);
signal SR_RX : std_logic_vector(7 downto 0);
signal CK57M : std_logic;
signal CK28M : std_logic;
signal CSB8_x : std_logic;
signal CSB9_x : std_logic;
signal CSBA_x : std_logic;
signal CSBB_x : std_logic;
signal CSBF_x : std_logic;
signal SNS_B8 : std_logic_vector(6 downto 0);
--signal SNS_BA : std_logic_vector(6 downto 0);
signal SNS_BB : std_logic_vector(6 downto 0);
signal SNS_BF : std_logic_vector(6 downto 0);

--
-- Components
--
component dpram256
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rdclock		: IN STD_LOGIC ;
		wraddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wrclock		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;

component pll57
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		c1		: OUT STD_LOGIC 
	);
end component;

begin

	--
	-- Instantiation
	--
	RAM0 : dpram256 PORT MAP (
		data	 => WDAT,
		rdaddress	 => XFADR,
		rdclock	 => CK28M,
		wraddress	 => WADR,
		wrclock	 => ZCLK,
		wren	 => ENW,
		q	 => FDAT
	);

	CKGEN0 : pll57 PORT MAP (
		inclk0	 => SYS_CLK,
		c0	 => CK57M,
		c1	 => open
	);

	--
	-- Chip Select
	--
	CSB8_x<='0' when ZADDR(7 downto 0)=X"B8" and IORQ_x='0' else '1';
	CSB9_x<='0' when ZADDR(7 downto 0)=X"B9" and IORQ_x='0' else '1';
	CSBA_x<='0' when ZADDR(7 downto 0)=X"BA" and IORQ_x='0' else '1';
	CSBB_x<='0' when ZADDR(7 downto 0)=X"BB" and IORQ_x='0' else '1';
	CSBF_x<='0' when ZADDR(7 downto 0)=X"BF" and IORQ_x='0' else '1';

	--
	-- Registers
	--
	process( ZRST, ZCLK ) begin
		if ZRST_x='0' then
			WDAT<=(others=>'0');
			WADR<=(others=>'0');
			SNSWRM<='1';
			ENW<='0';
		elsif ZCLK'event and ZCLK='1' then
			if WR_x='0' then
--				if CSB8_x='0' then
--					--KANJI<=ZDTI(7);
--					--ENDIAN<=ZDTI(6);
--					--BANK<=ZDTI(1 downto 0);
--					FADR(15 downto 8)<=ZADDR(15 downto 8);
--					FADR(7 downto 0)<=ZDTI;
--				end if;
				if CSB9_x='0' then
					WDAT<=ZDTI;
				end if;
				if CSBA_x='0' then
					WADR<=ZDTI;
				end if;
			end if;
			SNSWRM<=CSB9_x or WR_x;
			if SNSWRM='0' and (CSB9_x='1' or WR_x='1') then
				ENW<='1';
			else
				ENW<='0';
			end if;
			if ENW='1' then
				WADR<=WADR+'1';
			end if;
		end if;
	end process;

	process( ZRST, CK57M ) begin
		if ZRST_x='0' then
			CK28M<='1';
			FCS<='1';
			FADR<=(others=>'0');
			BYTECNT<=(others=>'0');
			SR_TX<=(others=>'1');
			SR_RX<=(others=>'1');
		elsif CK57M'event and CK57M='1' then
			SNS_B8<=SNS_B8(5 downto 0)&CSB8_x;
--			SNS_BA<=SNS_BA(5 downto 0)&CSBA_x;
			SNS_BB<=SNS_BB(5 downto 0)&CSBB_x;
			SNS_BF<=SNS_BF(5 downto 0)&CSBF_x;
			if SNS_B8="1000000" and CSB8_x='0' and FCS='1' then
				FCS<='0';
				BITCNT<="000";
				BYTECNT<="100000011";
				SR_TX<="00000010";
				CK28M<='0';
				FADR<=ZADDR(15 downto 8)&ZDTI;
			end if;
--			if SNS_BA="1000000" and CSBA_x='0' and FCS='1' then
--				FCS<='0';
--				BITCNT<="000";
--				BYTECNT<=(others=>'0');
--				SR_TX<="00000110";
--				CK28M<='0';
--			end if;
			if SNS_BB="1000000" and CSBB_x='0' and FCS='1' then
				FCS<='0';
				BITCNT<="000";
				BYTECNT<=(others=>'0');
				SR_TX<=ZDTI;
				CK28M<='0';
			end if;
			if SNS_BF="1000000" and CSBF_x='0' and FCS='1' then
				FCS<='0';
				BITCNT<="000";
				BYTECNT<="000000001";
				SR_TX<="00000101";
				CK28M<='0';
			end if;
			if FCS='0' then
				if CK28M='0' then
					CK28M<='1';
				else
					SR_RX<=SR_RX(6 downto 0)&SFLASH_DATA;
					BITCNT<=BITCNT+'1';
					if BITCNT="111" then
						if CSB8_x='0' then
							if BYTECNT="100000011" then
								SR_TX<=FADR(15 downto 8);
							elsif BYTECNT="100000010" then
								SR_TX<=FADR(7 downto 0);
							elsif BYTECNT="100000001" then
								SR_TX<=(others=>'0');
							elsif BYTECNT/="000000000" then
								SR_TX<=FDAT;
							end if;
						else
							SR_TX<=SR_TX(6 downto 0)&'0';
						end if;
						if BYTECNT="000000000" then
							FCS<='1';
						else
							BYTECNT<=BYTECNT-'1';
							CK28M<='0';
						end if;
					else
						CK28M<='0';
						SR_TX<=SR_TX(6 downto 0)&'0';
					end if;
				end if;
			end if;
		end if;
	end process;

	--
	-- Data Bus
	--
	ZDTO<=SR_RX;
	ZDDIRi<='1' when RD_x='0' and CSBF_x='0' else '0';

	--
	-- Signals
	--
	ZWAIT_x<=FCS;
	XFADR<=not BYTECNT(7 downto 0);

	--
	-- Input Ports
	--
	ZDTI<=ZDT;
	ZRST_x<=not ZRST;

	--
	-- Output Ports
	--
	ZDOE<='0';
	DOPIO4<='0';	-- ZDTO(4)
	DOPIO5<='0';	-- ZDTO(5)
	ZDT<=ZDTO when ZDDIRi='1' else (others=>'Z');
	ZDDIR<=ZDDIRi;
	INT_x<='1';
	DOEPIO<='1';
	SFLASH_ASDI<=SR_TX(7);
	SFLASH_CSn<=FCS;
	SFLASH_DCLK<=CK28M;

	--
	-- Unused Outputs
	--
	USER_LED<=(others=>'1');

end rtl;
