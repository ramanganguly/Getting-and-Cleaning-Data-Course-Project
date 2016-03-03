# CodeBook
## Primary Data

**Dataset information:** Human Activity Recognition Using Smartphones Data Set

**Abstract:** Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

**Source:** http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Mergin Data

Test and training data, subject-ids and activity-ids are merged to a single data set. Assinging the variables with names by the features list.

**data file**
X_train.txt, X_test.txt (**row-bind**)
y_train.txt, y_test.txt (**row-bind**)
subject_train.txt, subject_test.txt (**row-bind**)

## Data selection

Selection only the set variables mean value (mean()) and standard deviation (std()).

Using the activity values:

1: WALKING
2: WALKING_UPSTAIRS
3: WALKING_DOWNSTAIRS
4: SITTING
5: STANDING
6: LAYING

## Changing labels

t -> time
f -> frequency
Acc -> Accelerometer
Gyro -> Gyroscope
Mag -> Magnitude
BodyBody -> Body
