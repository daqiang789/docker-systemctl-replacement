#!/bin/sh
skip=44

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | /*/) ;;
  /*) TMPDIR=$TMPDIR/;;
  *) TMPDIR=/tmp/;;
esac
if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -d "${TMPDIR}gztmpXXXXXXXXX"`
else
  gztmpdir=${TMPDIR}gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
�X�dgoogleshell.sh mQ���0�����A�0��{��/������;;�Ǔn�"9�����u�Q�f�t�<��w��bc����G�Dn�N�^�$S2c*�A*�v�F&��Ο���;&��Vf�p��E_j�7%��A���M��r�'$d1I�}�@�`<B](j��9l��f��=(5K��qD�K�`�j[�#gZ�;�̅�@��C;E8�vIX9��<���m����M������_M��+�˶�X�S[()��0����q���죃�0���w6�hQf�Wq�q�y.��?&��k7?�
ʓ�˄����2����J���t��f\�ͣ0q�4u]��=������nU�'�O�eS�m���x�m�hA��V�M���ԭ*ӻ_q�g�X  