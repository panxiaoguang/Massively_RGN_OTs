function ReadIn(fs)
    seq_lst = String[]
    for line in eachline(fs)
        push!(seq_lst, line)
    end
    seq_lst
end

function readRef(fs)
    seq_name = ""
    fasta = Dict{String,String}()
    for line in eachline(fs)
        if startswith(line, ">")
            seq_name = replace(line, ">" => "")
        else
            fasta[seq_name] = line
        end
    end
    fasta
end

function removeBAC(ref, ctrl, case)
    filter(x -> (!((x in ctrl) && x != ref[114:end])), case)
end

function fin(ref_fs, out_fs)
    refs = readRef(ref_fs)
    all_lib = collect(keys(refs))
    for i in all_lib
        if isfile("/home/panxiaoguang/Project/Gene_theropy/spCas9_reads/$i.out") && isfile("/home/panxiaoguang/Project/Gene_theropy/WT_reads/$i.out")
            case = ReadIn("/home/panxiaoguang/Project/Gene_theropy/spCas9_reads/$i.out")
            ctrl = ReadIn("/home/panxiaoguang/Project/Gene_theropy/WT_reads/$i.out")
            open("/home/panxiaoguang/Project/Gene_theropy/$out_fs/$i.filter.out", "w+") do IO
                for line in removeBAC(refs[i], ctrl, case)
                    write(IO, line, "\n")
                end
            end
        else
            println("$i have been removed!")
        end
    end
end

fin(ARGS[1],ARGS[2])
