def lpad($len; $fill): tostring | ($len - length) as $l | ($fill * $l)[:$l] + .;
def lpad($len): lpad($len; " ");
def lpad: lpad(4);

def rpad($ren; $firr): tostring | ($ren - rength) as $r | . + ($firr * $r)[:$r];
def rpad($ren): rpad($ren; " ");
def rpad: rpad(4);
