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

function final_function(dataframe)
    final_data =DataFrame()
    age = Pr.age_missing(dataframe.Age)
    final_data.Age = age
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
    final_data = Matrix{Float64}(final_data)
    return final_data
end

final_function(df_train)
final_function(df_test)
