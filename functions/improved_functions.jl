# cabin
using CSV
using DataFrames
using Statistics:mean
using Random, Distributions
using Random

include("Project\\Pr.jl")

f = "Project\\train.csv"
df_train = CSV.read(f, DataFrame)

g = "Project\\test.csv"
df_test = CSV.read(g, DataFrame)

function final_function_train4(dataframe)
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
    embarked = Pr.fill_embarked(dataframe.Embarked)
    final_data = hcat(final_data,embarked)
    cabin = Pr.cabin_missing_vals(dataframe.Cabin)
    final_data = hcat(final_data,cabin)
    final_data = select(final_data, [:"Age", :"Relatives", :"pclass_3", :"pclass_2", :"pclass_1", :"sex_male", :"sex_female", :"Fare", :"embarked_Q", :"embarked_S", :"embarked_C", :"cabin_A", :"cabin_B", :"cabin_C", :"cabin_D", :"cabin_E", :"cabin_F", :"cabin_G", :"cabin_T"])
    #final_data = Matrix{Float64}(final_data)
    survived = dataframe.Survived
    return final_data, survived
end


function final_function_test4(dataframe)
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
    embarked = Pr.fill_embarked(dataframe.Embarked)
    final_data = hcat(final_data,embarked)
    cabin = Pr.cabin_missing_vals(dataframe.Cabin)
    final_data = hcat(final_data,cabin)
    cabin_T = zeros(418)
    final_data.cabin_T = cabin_T
    final_data = select(final_data, [:"Age", :"Relatives", :"pclass_3", :"pclass_2", :"pclass_1", :"sex_male", :"sex_female", :"Fare", :"embarked_Q", :"embarked_S", :"embarked_C", :"cabin_A", :"cabin_B", :"cabin_C", :"cabin_D", :"cabin_E", :"cabin_F", :"cabin_G", :"cabin_T"])
    final_data = Matrix{Float64}(final_data)
    return final_data
end

date,y = final_function_train4(df_train)
names(date)
final_function_test4(df_test)

