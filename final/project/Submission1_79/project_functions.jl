# DEAL WITH MISSING VALUES
# AGE 
using DataFrames
using Statistics
using Statistics:mean
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

# FARE 
function fare_missing(fare,class)

    fare_class1 = Any[]
    fare_class2 = Any[]
    fare_class3 = Any[]
    
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

# EMBARKED
function drop_embarked(data)
    new_data = dropmissing(data, :"Embarked")
    return new_data
end 

# DROP COLUMNS 
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
    data_new = DataFrames.transform(sex_data, @. :sex => ByRow(isequal(uni))=> Symbol(:sex_,uni))
    return data_new[:,Not(1)]
end

# PARCH 
# combine sibsp and parch
# SIPSP 
# combine sibsp and parch 
function pasi_combine(sibsp,parch)
    relatives = sibsp .+ parch
    return relatives
end

# PCLASS 
# one hot encode pclass
function onehot_class(pclass)
    pclass_data = DataFrame()
    pclass_data.pclass = pclass
    uni = unique(pclass_data.pclass)
    data_new = DataFrames.transform(pclass_data, @. :pclass => ByRow(isequal(uni))=> Symbol(:pclass_,uni))
    return data_new[:,Not(1)]
end
# EMBARKED
# one hot encode embarked
function embarked_one_hot(embarked)
    embarked_data = DataFrame()
    embarked_data.Embarked = embarked
    uni = unique(embarked_data.Embarked)
    data_new = DataFrames.transform(embarked_data, @. :Embarked => ByRow(isequal(uni))=> Symbol(:embarked_,uni))
    return data_new[:,Not(1)]
end

# NORMALIZATION OF NUMERICAL FEATURES 
# Fare, Relatives 
function normalization(col)
    norm = float.(col)
    for (i,s) in enumerate(col)
        norm[i]= (s - minimum(col)) / (maximum(col) - minimum(col))
    end
    return norm
end


# Output Survived
function newsurvived(data)
    new_data = dropmissing(data, :"Embarked")
    return new_data.Survived
end 

"""
Input: dataframe
Output: final dataframe and vector about survival (y)
"""
function get_final_data(dataframe)
    final_data =DataFrame()
    age = age_missing(dataframe.Age)
    final_data.Age = age
    relatives = pasi_combine(dataframe.SibSp,dataframe.Parch)
    dataframe.Relatives = relatives
    relatives = normalization(dataframe.Relatives)
    final_data.Relatives = relatives
    pclass = onehot_class(dataframe.Pclass)
    final_data = hcat(final_data,pclass)
    sex = onehot_sex(dataframe.Sex)
    final_data = hcat(final_data,sex)
    fare = fare_missing(dataframe.Fare,dataframe.Pclass)
    final_data.Fare = fare
    fare = normalization(final_data.Fare)
    final_data.Fare = fare
    embarked = dataframe.Embarked
    final_data.Embarked = embarked
    final_data = dropmissing(final_data)
    embarked = embarked_one_hot(final_data.Embarked)
    final_data = hcat(final_data,embarked)
    final_data = select!(final_data, Not(:"Embarked"))
    final_data = Matrix{Float64}(final_data)
    survived = newsurvived(dataframe)
    return final_data, survived
end

function get_test_data(dataframe)
    final_data =DataFrame()
    age = age_missing(dataframe.Age)
    final_data.Age = age
    relatives = pasi_combine(dataframe.SibSp,dataframe.Parch)
    dataframe.Relatives = relatives
    relatives = normalization(dataframe.Relatives)
    final_data.Relatives = relatives
    pclass = onehot_class(dataframe.Pclass)
    final_data = hcat(final_data,pclass)
    sex = onehot_sex(dataframe.Sex)
    final_data = hcat(final_data,sex)
    fare = fare_missing(dataframe.Fare,dataframe.Pclass)
    final_data.Fare = fare
    fare = normalization(final_data.Fare)
    final_data.Fare = fare
    embarked = dataframe.Embarked
    final_data.Embarked = embarked
    final_data = dropmissing(final_data)
    embarked = embarked_one_hot(final_data.Embarked)
    final_data = hcat(final_data,embarked)
    final_data = select!(final_data, Not(:"Embarked"))
    final_data = Matrix{Float64}(final_data)
    return final_data
end


