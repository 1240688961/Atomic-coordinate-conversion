
dos2unix POSCAR
cp POSCAR aa
#get the lattice constance
ax=` awk 'NR==3{print $1}' aa`
bx=` awk 'NR==3{print $2}' aa`
cx=` awk 'NR==3{print $3}' aa`
ay=` awk 'NR==4{print $1}' aa`
by=` awk 'NR==4{print $2}' aa`
cy=` awk 'NR==4{print $3}' aa`
az=` awk 'NR==5{print $1}' aa`
bz=` awk 'NR==5{print $2}' aa`
cz=` awk 'NR==5{print $3}' aa`

# Get the total number of atoms
set -- $( sed '7q;d' aa )
atoms=0
while [ $# -gt 0 ]
do
	i=$1
	atoms=$( echo "$atoms + $i" | bc )
	shift
done

#judging whether to fix atoms
select=` awk 'NR==8{print $1}' aa`
echo $select
if [[ "$select" != S* ]]
then
	tail -n +9 aa > poscar1
else
	tail -n +10 aa > poscar1
fi


for((i=1;i<=$atoms;i++))
do
	xx=` sed -n ${i}p poscar1 |awk '{print $1}'`
	yy=` sed -n ${i}p poscar1 |awk '{print $2}'`
	zz=` sed -n ${i}p poscar1 |awk '{print $3}'`
	newx=$(echo "scale=10;$xx*$ax+$yy*($ay)+$zz*$az"|bc |awk '{printf "%.9f",$0}')
	newy=$(echo "scale=10;$xx*$bx+$yy*($by)+$zz*$bz"|bc |awk '{printf "%.9f",$0}')
	newz=$(echo "scale=10;$xx*$cx+$yy*($cy)+$zz*$cz"|bc |awk '{printf "%.9f",$0}')
	if [[ "$select" != S* ]]
	then
		j=`expr $i + 8 `
	else
		j=`expr $i + 9 `
	fi
	sed -i "${j}s/$xx/$newx/" aa
	sed -i "${j}s/$yy/$newy/" aa
	sed -i "${j}s/$zz/$newz/" aa    
done

sed -i "s/Direct/Cartesian/" aa
mv aa newposcar.vasp
rm   poscar1
