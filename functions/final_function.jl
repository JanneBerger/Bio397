#FINAL FUNCTION
using DataFrames
using Statistics:mean
using Random, Distributions
using Random
using CSV

include("Project\\Pr.jl")

f = "Project\\train.csv"
df_train = CSV.read(f, DataFrame)

g = "Project\\test.csv"
df_test = CSV.read(g, DataFrame)

"""
Input: dataframe
Output: final dataframe and vector about survival (y)
"""
function final_function_train(dataframe)
    final_data =DataFrame()
    age = Pr.age_missing(dataframe.Age)
    final_data.Age = age
    final_data.Age = Pr.normalization(final_data.Age)
    relatives = Pr.pasi_combine(dataframe.SibSp,dataframe.Parch)
    dataframe.Relatives = relatives
    relatives = Pr.normalization(dataframe.Relatives)
    final_data.Relatives = relatives
    pclass = Pr.onehot_class(dataframe.Pclass)
    final_data = hcat(final_data,pclass)
    sex = Pr.onehot_sex(dataframe.Sex)
    final_data = hcat(final_data,sex)
    fare = Pr.fare_missing(dataframe.Fare,dataframe.Pclass)
    final_data.Fare = fare
    fare = Pr.normalization(final_data.Fare)
    final_data.Fare = fare
    embarked = dataframe.Embarked
    final_data.Embarked = embarked
    final_data = dropmissing(final_data)
    embarked = Pr.embarked_one_hot(final_data.Embarked)
    final_data = hcat(final_data,embarked)
    final_data = select!(final_data, Not(:"Embarked"))
    #final_data = Matrix{Float64}(final_data)
    survived = Pr.newsurvived(dataframe)
    return final_data, survived
end

"""
Input: dataframe
Output: final dataframe 
"""
function final_function_test(dataframe)
    final_data =DataFrame()
    age = Pr.age_missing(dataframe.Age)
    final_data.Age = age
    final_data.Age = Pr.normalization(final_data.Age)
    relatives = Pr.pasi_combine(dataframe.SibSp,dataframe.Parch)
    dataframe.Relatives = relatives
    relatives = Pr.normalization(dataframe.Relatives)
    final_data.Relatives = relatives
    pclass = Pr.onehot_class(dataframe.Pclass)
    final_data = hcat(final_data,pclass)
    sex = Pr.onehot_sex(dataframe.Sex)
    final_data = hcat(final_data,sex)
    fare = Pr.fare_missing(dataframe.Fare,dataframe.Pclass)
    final_data.Fare = fare
    fare = Pr.normalization(final_data.Fare)
    final_data.Fare = fare
    embarked = dataframe.Embarked
    final_data.Embarked = embarked
    final_data = dropmissing(final_data)
    embarked = Pr.embarked_one_hot(final_data.Embarked)
    final_data = hcat(final_data,embarked)
    final_data = select!(final_data, Not(:"Embarked"))
    #final_data = Matrix{Float64}(final_data)
    return final_data
end

final_function_train(df_train)
final_function_test(df_test)
