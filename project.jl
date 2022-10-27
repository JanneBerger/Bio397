using DataFrames
using Statistics

f = "Project\\train.csv"
using CSV
df_train = CSV.read(f, DataFrame)

first(df_train)
describe(df_train)
mean(df_train.Survived)

# 9 columns
# Survived: Outcome of survival (0 = No; 1 = Yes)
# Pclass: Socio-economic class (1 = Upper class; 2 = Middle class; 3 = Lower class)
# Name: Name of passenger
# Sex: Sex of the passenger
# Age: Age of the passenger (Some entries contain NaN)
# SibSp: Number of siblings and spouses\Ehepartner of the passenger aboard
# Parch: Number of parents and children of the passenger aboard
# Ticket: Ticket number of the passenger
# Fare/Preis: Fare paid by the passenger
# Cabin  number of the passenger (Some entries contain NaN)
# Embarked: Port of embarkation of the passenger (C = Cherbourg; Q = Queenstown; S = Southampton)

using Plotly
using FileIO

age_plot = plot(df_train, x=:Age, kind="histogram", color=:Survived, Layout(barmode="stack"))
fare_plot = plot(df_train, x=:PassengerID, y=:Fare,color=:Survived,kind="scatter", mode="markers")
fare2_plot = plot(df_train, x=:Fare, kind="histogram", color=:Survived, Layout(barmode="stack"))
Pclass_plot = plot(df_train, x=:Pclass, kind="histogram", color=:Survived, Layout(barmode="stack"))
sex_plot = plot(df_train, x=:Sex, kind="histogram", color=:Survived, Layout(barmode="stack"))
SibSp_plot = plot(df_train, x=:SibSp, kind="histogram", color=:Survived, Layout(barmode="stack"))
Parch_plot = plot(df_train, x=:Parch, kind="histogram", color=:Survived, Layout(barmode="stack"))
Pid_plot = plot(df_train, x=:PassengerId, kind="histogram", color=:Survived, Layout(barmode="stack"))
carbin_plot = plot(df_train, x=:Cabin, kind="histogram", color=:Survived, Layout(barmode="stack")) 


savefig(age_plot,"Project\\age_plot.png")
savefig(fare_plot,"Project\\fare_plot.png")
savefig(fare2_plot,"Project\\fare2_plot.png")
savefig(Pclass_plot,"Project\\Pclass_plot.png")
savefig(sex_plot,"Project\\sex_plot.png")
savefig(SibSp_plot,"Project\\SibSp_plot.png")
savefig(Parch_plot,"Project\\Parch_plot.png")
savefig(Pid_plot,"Project\\Pit_plot.png")
savefig(carbin_plot,"Project\\carbin_plot.png")



