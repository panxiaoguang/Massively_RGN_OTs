import pysam
from pyfaidx import Fasta
import re
import sys


def get_filter_sequence(id, ref, samfile):
    sequence = [read.query_sequence for read in samfile.fetch(id)]
    start = ref[:113].upper()
    fin = []
    for seq in sequence:
        test = re.findall(r'{}[AGCT]+GTTT'.format(start), seq)
        if len(test) > 0:
            fin.append(test[0][113:-4])
    return fin


if __name__ == "__main__":
    refs = Fasta(sys.argv[1])
    samfile = pysam.AlignmentFile(sys.argv[2], 'rb')
    for record in refs:
        tmp = get_filter_sequence(record.name, str(record), samfile)
        if len(tmp) > 0:
            with open(f"{sys.argv[3]}/{record.name}.out", 'w+') as f:
                for line in tmp:
                    f.write(line+"\n")
