# cabin

#f = "Project\\train.csv"
#df_train = CSV.read(f, DataFrame)

#g = "Project\\test.csv"
#df_test = CSV.read(g, DataFrame)

function cabin_missing_vals(cabin)
    for i in  1:length(cabin)
        if ismissing(cabin[i])
            cabin[i] = "Undef"
        else
            cabin[i] = string(cabin[i][1])
        end
    end
    cabin_data = DataFrame()
    cabin_data.cabin = cabin
    uni = unique(cabin_data.cabin)
    data_new = transform(cabin_data, @. :cabin => ByRow(isequal(uni))=> Symbol(:cabin_,uni))
    return data_new[:,Not(1)]
end

#cabin_missing_vals(df_train.Cabin)

function fill_embarked(embarked)
    mostfrequent= mode(embarked)
    for (i , s) in enumerate(embarked)
        if ismissing(s)
            embarked[i]= mostfrequent
        end
    end
    embarked_data = DataFrame()
    embarked_data.embarked = embarked
    uni = unique(embarked_data.embarked)
    data_new = transform(embarked_data, @. :embarked => ByRow(isequal(uni))=> Symbol(:embarked_,uni))
    return data_new[:,Not(1)]
end

#fill_embarked(df_train.Embarked)

function final_function_train(dataframe)
    final_data =DataFrame()
    age = Pr.age_missing(dataframe.Age)
    final_data.Age = age
    final_data.Age = normalization(final_data.Age)
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
    embarked = fill_embarked(dataframe.Embarked)
    final_data = hcat(final_data,embarked)
    cabin = cabin_missing_vals(dataframe.Cabin)
    final_data = hcat(final_data,cabin)
    final_data = Matrix{Float64}(final_data)
    survived = Pr.newsurvived(dataframe)
    return final_data
end


function final_function_test(dataframe)
    final_data =DataFrame()
    age = Pr.age_missing(dataframe.Age)
    final_data.Age = age
    final_data.Age = normalization(final_data.Age)
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
    embarked = fill_embarked(dataframe.Embarked)
    final_data = hcat(final_data,embarked)
    cabin = cabin_missing_vals(dataframe.Cabin)
    final_data = hcat(final_data,cabin)
    final_data = Matrix{Float64}(final_data)
    return final_data
end

final_function_train(df_train)
final_function_test(df_test)