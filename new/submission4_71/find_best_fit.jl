using ScikitLearn
@sk_import model_selection: StratifiedKFold
@sk_import model_selection: GridSearchCV
@sk_import preprocessing: RobustScaler


"""
Input: X_train, y_train, model, parameters
Output: best_estimator, gridsearch
"""
function find_best_fit(X_train, y_train, model, parameters; nsplits=5, scoring="f1")

    # build the model and grid search object
    kf = StratifiedKFold(n_splits=nsplits, shuffle=true)
    gridsearch = GridSearchCV(model, parameters, scoring=scoring, cv=kf, n_jobs=1, verbose=0)
  
    # train the model
    fit!(gridsearch, X_train, y_train)
  
    best_estimator = gridsearch.best_estimator_
  
    return best_estimator, gridsearch
  end


# # Scale the data first
# rscale = RobustScaler()
# X_train = rscale.fit_transform(X_train)
  
# model = KNeighborsClassifier()
# parameters = Dict("n_neighbors" => 1:2:30, "weights" => ("uniform", "distance"))