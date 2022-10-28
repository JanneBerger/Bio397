# DEAL WITH MISSING VALUES
# AGE done
using DataFrames
using Statistics
using Random, Distributions
using Random
using CSV

function age_missing(age)
    mm = mean(skipmissing(age))
    sd = std(skipmissing(age))
    normal = Normal(mm,sd)
    age[ismissing.(age)] = rand(normal,length(age[ismissing.(age)]))
    return age
end

# FARE done
function fare_missing(fare,class)

    fare_class1 = Float64[]
    fare_class2 = Float64[]
    fare_class3 = Float64[]
    
    for i in (1:length(fare))
        if class[i] == 1
                push!(fare_class1,fare[i])
        elseif class[i] == 2
                push!(fare_class2,fare[i])
        elseif class[i] == 3
                push!(fare_class3,fare[i])
        end
    end

    mm1 = mean(skipmissing(fare_class1))
    
    mm2 = mean(skipmissing(fare_class2))
    
    mm3 = mean(skipmissing(fare_class3))

    for i in (1:length(fare))
        if isequal(missing, fare[i])
            if class[i] == 1
                fare[i] = mm1
            elseif class[i] == 2
                fare[i] = mm2
            elseif class[i] == 3
                fare[i] = mm3  
            end
        end   
    end 
    return fare
end

# EMBARKED While missing values done
function drop_embarked(data)
    new_data = dropmissing(data.embarked)
    return new_data
end 

# DROP COLUMNS done
function drop_columns(data)
    new_data = select!(data, Not(:Cabin))
    new_data = select!(data, Not(:Name))
    new_data = select!(data, Not(:Ticket))
    return new_data
end

# TRANSFORM FEATURES
# SEX done
# onehot encoding
function onehot_sex(sex)
    sex_data = DataFrame()
    sex_data.sex = sex
    uni = unique(sex_data.sex)
    data_new = transform(sex_data, @. :sex => ByRow(isequal(uni))=> Symbol(:sex_,uni))
    return data_new[:,Not(1)]
end

# PARCH done
# combine sibsp and parch
# SIPSP done
# combine sibsp and parch 
function pasi_combine(sibsp,parch)
    relatives = sibsp .+ parch
    return relatives
end

# PCLASS done
# one hot encode pclass
function onehot_class(pclass)
    pclass_data = DataFrame()
    pclass_data.pclass = pclass
    uni = unique(pclass_data.pclass)
    data_new = transform(pclass_data, @. :pclass => ByRow(isequal(uni))=> Symbol(:pclass_,uni))
    return data_new[:,Not(1)]
end

# NORMALIZATION OF NUMERICAL FEATURES 
# Fare, Relatives done
function normalization(col)
    norm = float.(col)
    for (i,s) in enumerate(col)
        norm[i]= (s - minimum(col)) / (maximum(col) - minimum(col))
    end
    return norm
end

#SCALE


