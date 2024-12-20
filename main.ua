# Experimental!

# PART 1
# Consists of two Caesar ciphers forming a single message, as well as a Vigenere
# cipher.

# These are the two Caesar ciphertexts.
A ← "KLUHTLISHJRVBADVYYPLKAOHAVBYJPWOLYPZAVVDLHRVUULEATLZZHNLZDPAJOAVCPNLULYLJPWOLYRLFDVYKPZAOLOPKKLUZFTIVSVMKLHAOPUTFMHCVYPALOVSILPULUK"
B ← "VWDUWLJUDEEHGHYHUBWKLQJLFRXOGILQGSOHDVHUHWXUQDQBEOXHSULQWVIRUYDXOWDQGDODUPGHVLJQEDVHGRQZKLFKEDQNBRXGHFLGHRQLDPVHWWLQJXSVDIHKRXVHFR"

# Brute-force by trying all 26 possible shifts (technically 25, but I included
# zero). Include shift in boxed array.
BruteCaesar ← ≡(⊂∩□) °⊏ ⍜(-@A|◿26) +⇡27 ¤
# Search for a marker to tell us which shift is correct (START or END, depending on the ciphertext).
FindMark! ← ▽⊸≡(/+◇⌕^0⊣)

∩(BruteCaesar) A B              # Brute-force both ciphertexts.
⊓FindMark!"END"FindMark!"START" # Find markers.
∩(&p°□⊣⊣)                       # Print correct deciphering.

# This is the Vigenere ciphertext.
$ KLKBNQLCYT
$ FYSRYUCOCP
$ HGBDIZZFCM
$ JWKUCHZYES
$ WFOGMMETWW
$ OSSDCHRZYL
$ DSBWNYDEDN
$ ZWNEFYDTHT
$ DDBOJICEML
$ UCDYGICCZH
$ OADRZCYLWA
$ DSXPILPIEC
$ SKOMOLTEJT
$ KMQQYMEHPM
$ MJXYOLWPEE
$ WJCKZNPCCP
$ SVSXAUYODH
$ ALMRIOCWPE
$ LWBCNIYFXM
$ WJCEMCYRAZ
$ DQLSOMDBFL
$ JWNBIJXPDD
$ SYOEHXPCES
$ WTOXWBLEEC
$ SAXCNUETZY
$ WFN
V ←
# Vigenere key.
VKey ← "SSKKUULLLL"

# Decipher Vigenere; functionally, it's equivalent to a Caesar cipher except the
# shift is given by the letter from the keyword instead of being constant.
▽⊸≠@\n V        # Filter out newlines from ciphertext.
⊸(↯¤:VKey ⧻)    # Get the length of the ciphertext and cycle key text to fit it.
≡⊟              # Pair up ciphertext characters with key characters.
&p ≡(+@A◿26 /-) # Get difference, convert to character, print.

# PART 2
# Consists of a 5x5 Polybius square cipher (row-column).

# Quick one-liner to generate the key grid.
PTwoKey        ← ¤↯5_5 +@A ⇡26
PTwoCipherText ← [
  4_4 5_4 1_1 3_4 5_4 1_1 2_3 3_3 5_3 4_4 5_4 1_2 4_2 4_3 4_2 4_4 3_2 5_1 4_1
  2_1 2_3 1_1 3_1 1_3 5_3 1_5 5_4 4_2 5_4 4_2 4_4 4_2 4_3 4_4 3_2 5_1 4_1 5_3
  4_3 5_4 3_2 4_2 3_4 4_1 1_1 2_5 5_1 3_5 5_3 3_4 1_3 4_2 4_3 2_2 5_3 4_3 1_1
  4_4 5_4 3_4 5_3 4_3 2_2 5_1 3_4 3_1 4_2 1_4 3_2 5_1 3_4 1_2 5_3 3_4 1_2 1_5
  5_4 1_5 3_4 5_1 3_3 5_1 4_4 4_4 1_1 2_2 5_1 4_4 4_2 5_4 4_2 4_4 4_4 1_5 3_4
  5_1 2_3 5_5 1_5 4_3 2_1 3_4 5_1 1_1 1_3 1_1 2_1 2_3 5_1 4_2 5_4 3_1 5_3 3_3
  2_1 4_2 4_3 5_1 4_4 5_3 1_5 3_4 1_4 3_4 5_1 2_5 4_2 5_3 1_5 4_4 3_3 5_1 5_4
  3_2 5_3 4_1 4_4 3_0 4_3 5_1 3_5 4_4
]

# Adjust ciphertext to be zero-indexed, treat each row as an index for a rank-2
# array, print resulting array.
&p ≡(⊡⇌) -1 PTwoCipherText PTwoKey

# PART 3
# Consists of a custom cipher and symbolic encoding. To decrypt ciphertext
# (after extraction from symbols), XOR with a bitstream key, then decrypt using
# a 6x6 Polybius square cipher filled in using a spiral formation by taking
# pairs of three-digit binary numbers as coordinates.

# Spiral 6x6 key for the Polybius grid.
PThreePolybius ← [
  "FGHIJK"
  "EXYZ0L"
  "DW781M"
  "CV692N"
  "BU543O"
  "ATSRQP"
]

# Source for the XOR bitstream key (thematically a one-time pad). This is an
# excerpt copied verbatim from this newspaper article:
# https://www.theglobeandmail.com/globe-investor/investment-ideas/dont-give-up-on-dividend-stocks/article12432498/
OTPText ← $ The whole grain goodness of blue chip dividend stocks has its limits.
          $ Utility stocks, consumer staples, pipelines, telecoms and real estate investment trusts have all lost ground over the past month, even while the broader market has been flat. With the bond market signalling an expectation of rising interest rates, the five-year rally for steady blue-chip dividend payers has stalled.
          $ Should you be scared if you own a lot of these stocks either directly or through mutual funds or exchange-traded funds? David Baskin, president of Baskin Financial Services, has a two-pronged answer: Keep your top-quality dividend stocks, but be prepared to follow his firm's example in trimming holdings in stocks such as TransCanada Corp., Keyera Corp. and Pembina Pipeline Corp.
# Generate the bitstream key by filtering for only alphabetic characters, then
# generate the bit based on whether the character is a vowel (including Y).
OTPKey ← ∈"AEIOUY" ▽⊸(×⊃(≥@A|≤@Z)) ⌵OTPText
# Ciphertext extracted from the given symbolic text.
PThreeCipherText ← [
  1 0 0 0
  1 1 1 1
  1 0 1 0
  1 0 0 1
  0 0 0 0
  1 1 1 1
  1 1 0 0
  0 0 0 1
  0 0 1 0
  1 0 0 0
  1 0 1 0
  0 0 1 0
  1 1 1 0
  1 0 0 0
  0 1 0 1
  1 1 1 1
  0 0 1 1
  1 1 0 0
  0 0 1 1
  1 1 1 0
  0 0 1 1
  0 0 0 0
  1 0 1 0
  0 0 0 1
  1 1 1 1
  1 0 1 1
  1 0 1 1
  0 1 0 0
  0 0 1 1
  1 0 0 0
  0 1 1 1
  0 1 1 1
  1 0 0 0
  0 0 0 1
  0 1 0 1
  0 0 1 1
  1 0 1 0
  1 0 0 0
  1 0 0 0
  1 0 0 0
  1 0 1 0
  1 1 1 1
  1 0 0 0
  0 1 1 1
  1 0 1 1
  0 1 1 1
  1 1 1 1
  1 0 1 0
  1 1 0 0
  1 1 1 1
  0 0 1 1
  1 0 0 0
  1 0 0 1
  0 1 0 0
  0 1 1 0
  0 1 0 1
  0 0 0 0
  1 1 1 0
  1 0 1 1
  0 1 1 1
  1 0 1 0
  0 0 1 0
  0 0 0 0
  0 1 0 0
  1 1 0 1
  0 0 1 0
  1 1 1 1
  1 0 0 0
  1 1 0 1
  0 0 1 1
  0 1 1 0
  0 0 0 1
  0 1 0 1
  1 1 1 1
  1 1 1 0
  1 0 1 1
  0 0 1 0
  0 0 0 1
  0 0 0 0
  1 1 1 0
  0 1 0 0
  0 1 0 0
  1 1 0 0
  0 0 0 1
  0 1 0 0
  1 0 1 1
  1 1 0 1
  0 1 0 0
  0 0 1 0
  0 0 0 0
  1 1 0 0
  1 0 1 1
  1 1 0 1
  0 1 0 0
  0 0 1 1
  0 0 1 1
  0 0 0 1
  0 0 1 0
  1 1 1 1
  0 0 1 0
  1 0 1 1
  1 0 0 1
  1 1 0 0
  0 1 1 0
  0 0 1 1
  0 1 1 0
  1 0 1 0
  0 0 0 0
  0 0 1 1
  0 1 1 1
  1 1 0 1
  0 0 0 0
  0 1 0 0
  0 1 0 1
  1 0 0 1
  0 0 1 1
  1 0 1 1
  0 0 1 0
  0 0 0 0
  0 1 1 1
  0 0 1 0
  1 1 1 0
  1 1 0 0
  1 1 0 1
  1 0 0 1
  1 1 1 1
  1 0 0 0
  0 0 1 0
  0 1 1 0
  1 1 1 1
  1 1 0 0
  0 0 0 0
  1 1 0 0
  0 1 1 0
  1 1 0 0
  0 1 1 1
  0 0 1 1
  0 0 0 1
  0 0 1 1
  0 0 1 1
  1 0 1 1
  1 0 1 0
  0 0 1 0
  1 1 0 0
  1 0 0 0
  0 0 1 1
  1 0 1 0
  1 0 1 1
  1 1 1 0
  1 0 1 1
  0 0 1 0
  0 0 1 0
  1 1 0 1
  1 0 0 0
  1 0 1 1
  0 1 1 1
  1 1 0 0
  0 0 1 0
]

ShortestLen ← ↧∩⧻ PThreeCipherText OTPKey # Find the shorter of ciphertext/key (key is too short)
∩(↙ShortestLen) PThreeCipherText OTPKey   # Truncate both arrays to shorter one.
≡≠                                        # XOR
↯∞_2_3                                    # Reshape into pairs of three-digit binary numbers.
≡₂(°⋯⇌)                                   # Turn each three-digit binary number into a decimal integer.
↧5                                        # Some coordinates are beyond the grid; this shouldn't happen, but there was likely a few errors while translating the symbols; just truncate them.
&p ≡⊡ :¤PThreePolybius                    # Decode the Polybius cipher and print.
