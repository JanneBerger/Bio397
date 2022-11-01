
using DataFrames

LogisticRegression(),  Dict("penalty" => ["l1","l2"], "C"=> 0.5:0.1:1)
KNeighborsClassifier(), Dict("n_neighbors" => 1:2:30, "weights" => ("uniform", "distance"))
DecisionTreeClassifier(), Dict("criterion" => ["gini", "entropy", "log_loss"],"class_weight" => ["balanced"])
RandomForestClassifier(), Dict("n_estimators" => 50:20:150, "min_weight_fraction_leaf" => 0:0.2:1)
GaussianNB(), Dict()

#models = [LogisticRegression(),KNeighborsClassifier(),DecisionTreeClassifier(),RandomForestClassifier(),GaussianNB()]
#parameters = [Dict("penalty" => ["l1","l2"], "C"=> 0.5:0.1:1), Dict("n_neighbors" => 1:2:30, "weights" => ("uniform", "distance")),  ]
#df = DataFrame()


