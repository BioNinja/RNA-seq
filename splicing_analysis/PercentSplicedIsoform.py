def vec2psi(inc,skp,effective_inclusion_length,effective_skipping_length):
        psi=[];
        inclusion_length=effective_inclusion_length;
        skipping_length=effective_skipping_length;
        for i in range(len(inc)):
                if (float(inc[i])+float(skp[i]))==0:
                        psi.append("NA");
                else:
                        psi.append(str(round(float(inc[i])/inclusion_length/(float(inc[i])/inclusion_length+float(skp[i])/skipping_length),3)));
        return(psi);

        