
####################

cat blastpOut1.txt|cut -f1|sort|uniq >blastpOut.cutf1

cat blastpOut.cutf1|xargs -I{} grep -w -m1 {} blastpOut1.txt >tmp && mv tmp blastpOut1.txt

chmod 400 blastpOut1.txt

less blastpOut1.txt|cut -f4|sed 's/.*Tax=//;s/ TaxID.*//' >blastpOut.cutTAX

less blastpOut1.txt|cut -f1,3,4 >blastpOut.cutf134


less blastpOut.cutf1|xargs -I{} grep -w {} Abndncefiltered.NwOut-fc.txt >blastpOut1.abundance

paste blastpOut.cutf134 blastpOut.cutTAX >blastpOut.cutf134TAX

cut -f2- blastpOut1.abundance >tmp && mv tmp blastpOut1.abundance

paste blastpOut.cutf134TAX blastpOut1.abundance >tmp && mv tmp blastpOut1.abundance

chmod 400 blastpOut1.abundance


######## filtering based on pident >75 and qcovs >60 #########
less blastpOut1.txt|cut -f1,8,9|awk '{if ($2 > 60 && $3 > 75) print $0}'|cut -f1 >blastpOut1.txt.abovePidentQcovsThreshold.cutf1

cat blastpOut1.txt.abovePidentQcovsThreshold.cutf1|xargs -I{} grep -w {} blastpOut1.abundance >blastpOut1.abundance.abovePidentQcovsThreshold

chmod 400 blastpOut1.abundance.abovePidentQcovsThreshold

cut -f1 blastpOut1.abundance.abovePidentQcovsThreshold >F1

less blastpOut1.abundance.abovePidentQcovsThreshold|sed 's/.*TaxID=//;s/ RepID.*//'>FTAXID

paste F1 FTAXID >blastpOut1.abundance.abovePidentQcovsThreshold.cutF1TAXID

grep -Fw -f uniprot_taxaBacteriaWlineage.tsv.CUTF1 blastpOut1.abundance.abovePidentQcovsThreshold.cutF1TAXID >OUT.BACTAXID

less OUT.BACTAXID|cut -f2 >OUT.BACTAXID.cutF2

cat OUT.BACTAXID.cutF2 | xargs -I {} grep -Fw {} uniprot_taxaBacteriaWlineage.tsv.CUTF14 -m1 > OUT.BACTAXID.Lineage

chmod 400 OUT.BACTAXID.Lineage

cut -f1 OUT.BACTAXID >OUT.BACTAXID.cutF1

less OUT.BACTAXID.cutF1|xargs -I{} grep -w {} blastpOut1.abundance.abovePidentQcovsThreshold >BAC.out.abundance

cut -f1-4 BAC.out.abundance >ff14

cut -f5- BAC.out.abundance >ff5R

paste ff14 OUT.BACTAXID.Lineage ff5R >BAC.out.abundance

chmod 400 BAC.out.abundance

wc -l OUT.BACTAXID >CheckPoints
wc -l OUT.BACTAXID.Lineage >>CheckPoints
wc -l BAC.out.abundance >>CheckPoints


grep -Fw -f uniprot_taxaFungi.CUTF1 blastpOut1.abundance.abovePidentQcovsThreshold.cutF1TAXID >OUT.FUNGTAXID
grep -Fw -f uniprot_taxaBovine.CUTF1 blastpOut1.abundance.abovePidentQcovsThreshold.cutF1TAXID >OUT.BOVTAXID
grep -Fw -f uniprot_taxaHomo.CUTF1 blastpOut1.abundance.abovePidentQcovsThreshold.cutF1TAXID >OUT.HOMOTAXID

echo "annotated proteins" > FinalNumbers
wc -l blastpOut1.abundance >>FinalNumbers
echo "annotated proteins above threshold" >> FinalNumbers
wc -l blastpOut1.abundance.abovePidentQcovsThreshold >>FinalNumbers
echo "bacterial proteins" >>FinalNumbers
wc -l OUT.BACTAXID >>FinalNumbers
echo "fungal proteins" >>FinalNumbers
wc -l OUT.FUNGTAXID >>FinalNumbers
echo "bovine proteins" >>FinalNumbers
wc -l OUT.BOVTAXID >>FinalNumbers
echo "human proteins" >>FinalNumbers
wc -l OUT.HOMOTAXID >> FinalNumbers

