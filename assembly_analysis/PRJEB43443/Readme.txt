###########Analysis of output from assembly based projects#########

-> a.sh : script to create all the downstream files
-> input files for a.sh :
	<> Abndncefiltered.NwOut-fc.txt : filtered feature count file created by filtering all the contigs with abundance greter than 3 in all the samples from the original feature count file (NwOut-fc.txt)
	<> blastpOut1.txt : blastp annotation of the contig proteins
-> major output files: 
	<> blastpOut1.abundance : blastp annotation of the contig proteins with their sample-wise abundance
	<> blastpOut1.abundance.abovePidentQcovsThreshold : filtered (threshold =identity >=75 and query coverage >=60) blastp annotation of the contig proteins with their sample-wise abundance
	<> BAC.Out.abundance : blastp annotation of the Bacterial contig proteins with their sample-wise abundance
	<> FinalNumbers : Final protein numbers for bacteria, fungi, bovine and human
-> Other major files:
	uniprot taxonomy files for bacteria, fungi, bovine and human
