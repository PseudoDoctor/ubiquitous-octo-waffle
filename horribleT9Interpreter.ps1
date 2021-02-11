<#
Worst T-9 texting interpreter ever
    123
    456
    789
    0
    1=$null
    2=abc
    3=def
    4=ghi
    5=jkl
    6=mno
    7=pqrs
    8=tuv
    9=wxyz


#>
$NCIStext="66666555999466684425555553336669922666
44447777777744433333153327776677773666
833333337666333382266699"
$NCIStext2="6666655599946668442555555333666992266644447777777744433333153327776677773666833333337666333382266699"
$numpad = @{
    '1' = @($null);
    '2' = @('a','b','c');
    '3' = @('d','e','f');
    '4' = @('g','h','i');
    '5' = @('j','k','l');
    '6' = @('m','n','o');
    '7' = @('p','q','r','s');
    '8' = @('t','u','v');
    '9' = @('w','x','y','z');
}
$padnum = @(
    @('0'),
    @('1'),
    @('a','b','c','2'),
    @('d','e','f','3'),
    @('g','h','i','4'),
    @('j','k','l','5'),
    @('m','n','o','6'),
    @('p','q','r','s','7'),
    @('t','u','v','8'),
    @('w','x','y','z','9')
)

function possibleletters {
    [cmdletbinding()]
    param([int]$meep)

    $padnum = @(
    @('0'),
    @('1'),
    @('a','b','c','2'),
    @('d','e','f','3'),
    @('g','h','i','4'),
    @('j','k','l','5'),
    @('m','n','o','6'),
    @('p','q','r','s','7'),
    @('t','u','v','8'),
    @('w','x','y','z','9')
    )
    
    $meepLength=$meep.ToString().Length;
    $first=$meep.ToString()[0].ToString();
    $characters=$numpad[$first];
    $charactersLength=$characters.Length;

    Write-Verbose ("Input: "+$meep);
    Write-Verbose ("Characters: "+$characters);

    for($i=0;$i -lt $charactersLength;$i++){
        if(($i+1) -gt $meepLength){
            #not enough characters to get presses, die?
            Write-Verbose "$i is less than remaining presses $meepLength , Do nothing";
      
        }
        else {
            Write-Verbose ("with "+($i+1)+" presses of $first, the resulting letter would be: "+$padnum[$first][$i])
            echo $padnum[$first][$i];
            if(($meepLength-$i-1) -gt 0) {
                Write-Verbose ("Remaining number of digits to process: "+($meepLength-$i-1)+"")
                $next=$first*($meepLength-$i-1);
                possibleletters $next;
            }
            else{
                #out of digits/presses. What do?
                Write-Verbose "No more digits to pass, do nothing"
            }
        }
    }
    Write-Verbose "===End of this set of possible characters.==="
    echo ""
}

function toT9 {
    [cmdletbinding()]
    param([string]$blah)

    

    #convert string to number of presses of each digit to get corresponding number
    <#
     0=0
     1=1
     2=abc2
     3=def3
     4=ghi4
     5=jkl5
     6=mno6
     7=pqrs7
     8=tuv8
     9=wxyz9
    Examples:
     a  2
     b  22
     ab  222
     hello  4433555555666
     1q2w3e 17722229333333
     nom  666666
     ipv4  444778884444
     ipv6  444778886666
    #>

    <#
        The extra $null entries allow us to use array indices to reference he Digit pressed and the number of times pressed
        Examples
        $padnum[0][1]  0
        $padnum[2][2]  b
        $padnum[8][1]  t
        $padnum[$digit][$presses]  $output
    #>
    #Presses 1   2   3   4   5
    $padnum = @(
    @($null,"0"),
    @($null,"1"),
    @($null,"a","b","c","2"),
    @($null,"d","e","f","3"),
    @($null,"g","h","i","4"),
    @($null,"j","k","l","5"),
    @($null,"m","n","o","6"),
    @($null,"p","q","r","s","7"),
    @($null,"t","u","v","8"),
    @($null,"w","x","y","z","9")
    )

    [string]$output = ""
    Write-Verbose "Input string: $blah";
    for($i=0;$i -lt $blah.Length;$i++){
        Write-Verbose ("Converting Character: "+$blah[$i]+" to T9 digit presses");
        for($digit=0;$digit -lt $padnum.Length;$digit++){
            for($presses=1;$presses -lt $padnum[$digit].length;$presses++){
                Write-Verbose ("Looking at $digit with $presses presses which is "+$padnum[$digit][$presses]);
                if( $blah[$i].ToString().Equals($padnum[$digit][$presses].ToString()) ){
                    Write-Verbose ("Result is $digit pressed $presses times, which looks like this: "+ ($digit.ToString()*$presses));
                    $output += ($digit.ToString()*$presses);
                }
            }
        }
    }

    echo $output
}

function fromT9 {
    [cmdletbinding()]
    param([string]$blah)
    Write-Verbose "fromT9"
    <#
        spits out characters associated with number of digit presses
        Initially only supports repeating digits
        @($null,"p","q","r","s","7"),
        7 will spit out p
        77 will spit out q
        777 will spit out r
        7777 will spit out s
        77777 will spit out 7
        777777 will spit out 7p
        If you want rr, you'll have to call fromT9 twice.
    #>
      $padnum = @(
    @($null,"0"),
    @($null,"1"),
    @($null,"a","b","c","2"),
    @($null,"d","e","f","3"),
    @($null,"g","h","i","4"),
    @($null,"j","k","l","5"),
    @($null,"m","n","o","6"),
    @($null,"p","q","r","s","7"),
    @($null,"t","u","v","8"),
    @($null,"w","x","y","z","9")
    )

    [string]$first = $blah[0];
    if($blah.Length -ge $padnum[$first].Length){
        # too many digits, recurse
        $remaining = $blah.Length - $padnum[$first].Length + 1
        [string]$next = $first.ToString() * $remaining
        [string]$keep = $first.ToString() * ($padnum[$first].Length - 1)
        $foo = $padnum[$first]
        Write-Verbose ("$blah has too many presses for "+$foo+", truncating to $keep and $next and try again")
        $before = fromT9 $keep
        $after = fromT9 $next
        Write-Verbose ("Result: $before And: $after")
        echo (""+$before+""+$after+"")
    }
    else{
        $output = $padnum[$first][$blah.Length]
        Write-Verbose ("$first pressed "+$blah.Length+" times is $output")   
        echo $output
    }
}

function monster {
    param($blah)
        
 $padnum = @(
    @($null,"0"),
    @($null,"1"),
    @($null,"a","b","c","2"),
    @($null,"d","e","f","3"),
    @($null,"g","h","i","4"),
    @($null,"j","k","l","5"),
    @($null,"m","n","o","6"),
    @($null,"p","q","r","s","7"),
    @($null,"t","u","v","8"),
    @($null,"w","x","y","z","9")
  )
    <#
        for lack of better options or maths or whatever, I am going to do the following:
        Take a string of repeating digits
        Pump the characters in $padnum associated with that digit
        Do n choose k combintations for those characters
        Send each combination through toT9 function
        Output any matches
        
        Example:
        222 has 3 digits
        '2' has 4 characters associated with it
        'aaa' 2.  2.  2.
        'ab'  2.  22.
        'ba'  22. 2.
        'c'   222.

        2222
        4 digits
        4 characters
        aaaa 2. 2. 2. 2.
        aab  2. 2. 22.
        aba  2. 22. 2.
        ac   2. 222.
        baa  22. 2. 2.
        bb   22. 22.
        ca   222. 2.
        2    2222.

        777777
        6 digits
        5 characters
        @($null,"p","q","r","s","7"),
        pppppp 7.7.7.7.7.7.
        ppppq  7.7.7.7.77.
        pppr   7.7.7.777.
        pps    7.7.7777.
        p7     7.77777.
        qpppp  77.7.7.7.7.
        qppq   77.7.7.77.
        qpr    77.7.777.
        qs     77.7777.
        rppp   777.7.7.7.
        rpq    777.7.77.
        rr     777.777
        spp    7777.7.7.
        sq     7777.77.
        7p     77777.7

        And so on and so forth
    #>

}

function combinations {
    [cmdletbinding()]
    param([string]$waffle,[int]$splitcount=0)
    Write-Verbose "combinations"
    [string]$output=""
    Write-Verbose ("input" + $waffle +" split count "+ $splitcount.ToString())
    #lots of recursion
    if($splitcount -eq 0) {
        # Nothing to split, spit out $input
        $output = $waffle;
    }
    else{
        # need to split as many times as there are characters
        for($i=1;$i -lt $waffle.Length;$i++){
            $front = $waffle.Substring(0,$i)
            $back = combinations $waffle.Substring($i) ($splitcount - 1)
            Write-Verbose "Front $front Back $back"
            echo ($front +","+ $back)
        }
    }
    Write-Verbose ("Output $output");
    echo $output
}


"Test 1, Text A,", "Test 2, Text B,", ",,", ",", ",,," | Where {([regex]"^[,]+$").match($_).Success}

function reversetext {
    param([string]$input);
    $inputArray = $input.ToCharArray();;
    [array]::Reverse($inputArray);
    $output = -join($inputArray);
    echo $output;
}

function genericFromT9 {
    [cmdletbinding()]
    param([string]$string="33333444444")
    
      $chars = $string.ToCharArray()
      $tosend = ""
      for($i=1;$i -le $chars.Length;$i++) {
        if ($chars[$i-1] -eq $chars[$i]) {
            $tosend += $chars[$i]
        }
        else{
            $tosend += $chars[$i-1];
            fromT9 $tosend -Verbose;
            $tosend = $chars[$i];
        }
      }
}

function genericFromT9 {
    [cmdletbinding()]
    param([string]$string="33333444444")
    
      $chars = $string.ToCharArray()
      $tosend = ""
      for($i=1;$i -le $chars.Length;$i++) {
        if ($chars[$i-1] -eq $chars[$i]) {
            $tosend += $chars[$i]
        }
        else{
            $tosend += $chars[$i-1];
            fromT9 $tosend -Verbose;
            $tosend = $chars[$i];
        }
      }
}

function advancedFromT9 {
    [cmdletbinding()]
    param([string]$string="33333444444")
      Write-Verbose "=== AdvancedFromT9 input $string"
      if ($string -match ","){
        # comma, split and try agagin
        $combined = $string.Split(",") | % {
            advancedFromT9 $_
        }
        echo $combined;
      }
      else{
        $chars = $string.ToCharArray()
        $tosend = ""
        for($i=1;$i -le $chars.Length;$i++) {
            if ($chars[$i-1] -eq $chars[$i]) {
                $tosend += $chars[$i]
            }
            else{
                #still need previous character
                $tosend += $chars[$i-1];
                fromT9 $tosend;
                #reset for next pass
                $tosend = "";
            }
        }
     }
}
function get_all_substrings{
    param([string]$input_string)
    $length = $input_string.Length
    for($i=0;$i -lt $length;$i++){
        for($j=$i;$j -lt $length;$j++){
            echo $input_string.Substring($i,$j+1-$i)
        }
    }
}

$dictionary = Get-Content C:\users\onine\Downloads\words.txt
$dict = "fox
earn
bow"