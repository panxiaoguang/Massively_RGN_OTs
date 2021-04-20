using CSV
using DataFrames

function panduan(x)
    buyao = vcat(string.(1:14) .* "I1", string.(22:27) .* "I1", string.(1:14) .* "D1", string.(22:27) .* "D1")
    !all(in.(x, Ref(buyao)))
end

function modify_df(fs)
    df = DataFrame(CSV.File(fs, delim="\t"))
    if (eltype(df.insertions) == Missing && eltype(df.deletions) == Missing) | (size(df)[1] == 0)
        return Missing
    elseif eltype(df.insertions) == Missing
        df.insertions = string.(df.insertions)
        df.insertions .= ""
    elseif eltype(df.deletions) == Missing
        df.deletions = string.(df.deletions)
        df.deletions .= ""
    end
    df[:,[:insertions,:deletions]] .= ifelse.(ismissing.(df[:,[:insertions,:deletions]]), "", df[:,[:insertions,:deletions]])
    df = select(df, :reference, :query, :count, AsTable(4:5) => ByRow(x -> split(strip(join([x.insertions,x.deletions], "|"), ['|']), "|")) => :indels)
    sort!(df, order(:count, rev=true))
    df = df[panduan.(df.indels),:]
    df
end

buxing(x) = !((length(x) == 1) && (x[1] == ""))

function calIndel(x)
    if x == Missing
        return 0, 0
    end
    cleanReadNumbers = sum(x.count)
    indelReadNumbers = sum(x[buxing.(x.indels),:].count)
    cleanReadNumbers, indelReadNumbers
end


for i in string.(11259:11527)
    if isfile("/home/panxiaoguang/Project/Gene_theropy/spCas9_indelProfile/$i.indelProfile.tsv")
        clean, indels = calIndel(modify_df("/home/panxiaoguang/Project/Gene_theropy/spCas9_indelProfile/$i.indelProfile.tsv"))
        println(i, "\t", clean, "\t", indels)
    end
end
