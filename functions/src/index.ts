import * as functions from "firebase-functions";
import admin = require("firebase-admin");

admin.initializeApp();

const firestoreDatabase = admin.firestore();

if (process.env.FUNCTIONS_EMULATOR) {
  console.log("we are running firebase emulator................");

  //   const populator = new FakeDataPopulator(firestoreDatabase);
  //   populator.generateFakeData();
}

exports.onNewFoodAdded = functions.firestore
  .document("./users/{userId}/foods/{date}/{mealType}/{foodId}")
  .onCreate(async (snapshot, context) => {
    const userId = context.params.userId;
    const date = context.params.date;
    const mealType = context.params.mealType;

    let isStoredLocally: boolean = snapshot.data()?.isStoredLocally;

    if (!isStoredLocally) {
      // add food to history
      await firestoreDatabase
        .collection("users")
        .doc(userId)
        .collection("history")
        .add(snapshot.data());
    }

    let newInsertedFoodCalories = snapshot.data()?.calories;
    let dailyCaloriesGoal =
      snapshot.data()?.caloriesDetails["dailyCaloriesGoal"];
    let totalCaloriesConsumed =
      snapshot.data()?.caloriesDetails["totalCaloriesConsumed"];
    let caloriesBurned = snapshot.data()?.caloriesDetails["caloriesBurned"];
    let caloriesRemaining =
      snapshot.data()?.caloriesDetails["caloriesRemaining"];
    let totalBreakfastCalories =
      snapshot.data()?.caloriesDetails["totalBreakfastCalories"];
    let totalLunchCalories =
      snapshot.data()?.caloriesDetails["totalLunchCalories"];
    let totalDinnerCalories =
      snapshot.data()?.caloriesDetails["totalDinnerCalories"];
    let totalSnacksCalories =
      snapshot.data()?.caloriesDetails["totalSnacksCalories"];

    if (mealType == "breakfast") {
      totalBreakfastCalories = totalBreakfastCalories + newInsertedFoodCalories;
    } else if (mealType == "lunch") {
      totalLunchCalories = totalBreakfastCalories + newInsertedFoodCalories;
    } else if (mealType == "dinner") {
      totalDinnerCalories = totalDinnerCalories + newInsertedFoodCalories;
    } else if (mealType == "snacks") {
      totalSnacksCalories = totalSnacksCalories + newInsertedFoodCalories;
    }

    totalCaloriesConsumed =
      totalBreakfastCalories +
      totalLunchCalories +
      totalDinnerCalories +
      totalSnacksCalories;

    caloriesRemaining =
      dailyCaloriesGoal - totalCaloriesConsumed + caloriesBurned;

    return await firestoreDatabase
      .collection("users")
      .doc(userId)
      .collection("foods")
      .doc(date)
      .set({
        dailyCaloriesGoal: dailyCaloriesGoal,
        totalCaloriesConsumed: totalCaloriesConsumed,
        caloriesBurned: caloriesBurned,
        caloriesRemaining: caloriesRemaining,
        totalBreakfastCalories: totalBreakfastCalories,
        totalLunchCalories: totalLunchCalories,
        totalDinnerCalories: totalDinnerCalories,
        totalSnacksCalories: totalSnacksCalories,
      });
  });

exports.onFoodUpdated = functions.firestore
  .document("./users/{userId}/foods/{date}/{mealType}/{foodId}")
  .onUpdate(async (change, context) => {
    const userId = context.params.userId;
    const date = context.params.date;
    const mealType = context.params.mealType;

    let newInsertedFoodCalories = change.after.data()?.calories;
    let dailyCaloriesGoal =
      change.after.data()?.caloriesDetails["dailyCaloriesGoal"];
    let totalCaloriesConsumed =
      change.after.data()?.caloriesDetails["totalCaloriesConsumed"];
    let caloriesBurned = change.after.data()?.caloriesDetails["caloriesBurned"];
    let caloriesRemaining =
      change.after.data()?.caloriesDetails["caloriesRemaining"];
    let totalBreakfastCalories =
      change.after.data()?.caloriesDetails["totalBreakfastCalories"];
    let totalLunchCalories =
      change.after.data()?.caloriesDetails["totalLunchCalories"];
    let totalDinnerCalories =
      change.after.data()?.caloriesDetails["totalDinnerCalories"];
    let totalSnacksCalories =
      change.after.data()?.caloriesDetails["totalSnacksCalories"];

    if (mealType == "breakfast") {
      totalBreakfastCalories = totalBreakfastCalories + newInsertedFoodCalories;
    } else if (mealType == "lunch") {
      totalLunchCalories = totalBreakfastCalories + newInsertedFoodCalories;
    } else if (mealType == "dinner") {
      totalDinnerCalories = totalDinnerCalories + newInsertedFoodCalories;
    } else if (mealType == "snacks") {
      totalSnacksCalories = totalSnacksCalories + newInsertedFoodCalories;
    }

    totalCaloriesConsumed =
      totalBreakfastCalories +
      totalLunchCalories +
      totalDinnerCalories +
      totalSnacksCalories;

    caloriesRemaining =
      dailyCaloriesGoal - totalCaloriesConsumed + caloriesBurned;

    return await firestoreDatabase
      .collection("users")
      .doc(userId)
      .collection("foods")
      .doc(date)
      .set({
        dailyCaloriesGoal: dailyCaloriesGoal,
        totalCaloriesConsumed: totalCaloriesConsumed,
        caloriesBurned: caloriesBurned,
        caloriesRemaining: caloriesRemaining,
        totalBreakfastCalories: totalBreakfastCalories,
        totalLunchCalories: totalLunchCalories,
        totalDinnerCalories: totalDinnerCalories,
        totalSnacksCalories: totalSnacksCalories,
      });
  });

exports.onFoodDeleted = functions.firestore
  .document("./users/{userId}/foods/{date}/{mealType}/{foodId}")
  .onDelete(async (snapshot, context) => {
    const userId = context.params.userId;
    const date = context.params.date;
    const mealType = context.params.mealType;

    let deletedFoodCalories = snapshot.data()?.calories;
    let dailyCaloriesGoal =
      snapshot.data()?.caloriesDetails["dailyCaloriesGoal"];
    let totalCaloriesConsumed =
      snapshot.data()?.caloriesDetails["totalCaloriesConsumed"];
    let caloriesBurned = snapshot.data()?.caloriesDetails["caloriesBurned"];
    let caloriesRemaining =
      snapshot.data()?.caloriesDetails["caloriesRemaining"];
    let totalBreakfastCalories =
      snapshot.data()?.caloriesDetails["totalBreakfastCalories"];
    let totalLunchCalories =
      snapshot.data()?.caloriesDetails["totalLunchCalories"];
    let totalDinnerCalories =
      snapshot.data()?.caloriesDetails["totalDinnerCalories"];
    let totalSnacksCalories =
      snapshot.data()?.caloriesDetails["totalSnacksCalories"];

    if (mealType == "breakfast") {
      totalBreakfastCalories = totalBreakfastCalories - deletedFoodCalories;
    } else if (mealType == "lunch") {
      totalLunchCalories = totalBreakfastCalories - deletedFoodCalories;
    } else if (mealType == "dinner") {
      totalDinnerCalories = totalDinnerCalories - deletedFoodCalories;
    } else if (mealType == "snacks") {
      totalSnacksCalories = totalSnacksCalories - deletedFoodCalories;
    }

    totalCaloriesConsumed =
      totalBreakfastCalories +
      totalLunchCalories +
      totalDinnerCalories +
      totalSnacksCalories;

    caloriesRemaining =
      dailyCaloriesGoal - totalCaloriesConsumed + caloriesBurned;

    return await firestoreDatabase
      .collection("users")
      .doc(userId)
      .collection("foods")
      .doc(date)
      .update({
        dailyCaloriesGoal: dailyCaloriesGoal,
        totalCaloriesConsumed: totalCaloriesConsumed,
        caloriesBurned: caloriesBurned,
        caloriesRemaining: caloriesRemaining,
        totalBreakfastCalories: totalBreakfastCalories,
        totalLunchCalories: totalLunchCalories,
        totalDinnerCalories: totalDinnerCalories,
        totalSnacksCalories: totalSnacksCalories,
      });
  });

exports.onUserUpdated = functions.firestore
  .document("./users/{userId}")
  .onUpdate(async (change, context) => {
    const userId = context.params.userId;
    const date = context.params.date;
    const mealType = context.params.mealType;

    let newInsertedFoodCalories = change.after.data()?.calories;
    let dailyCaloriesGoal =
      change.after.data()?.caloriesDetails["dailyCaloriesGoal"];
    let totalCaloriesConsumed =
      change.after.data()?.caloriesDetails["totalCaloriesConsumed"];
    let caloriesBurned = change.after.data()?.caloriesDetails["caloriesBurned"];
    let caloriesRemaining =
      change.after.data()?.caloriesDetails["caloriesRemaining"];
    let totalBreakfastCalories =
      change.after.data()?.caloriesDetails["totalBreakfastCalories"];
    let totalLunchCalories =
      change.after.data()?.caloriesDetails["totalLunchCalories"];
    let totalDinnerCalories =
      change.after.data()?.caloriesDetails["totalDinnerCalories"];
    let totalSnacksCalories =
      change.after.data()?.caloriesDetails["totalSnacksCalories"];

    if (mealType == "breakfast") {
      totalBreakfastCalories = totalBreakfastCalories + newInsertedFoodCalories;
    } else if (mealType == "lunch") {
      totalLunchCalories = totalBreakfastCalories + newInsertedFoodCalories;
    } else if (mealType == "dinner") {
      totalDinnerCalories = totalDinnerCalories + newInsertedFoodCalories;
    } else if (mealType == "snacks") {
      totalSnacksCalories = totalSnacksCalories + newInsertedFoodCalories;
    }

    totalCaloriesConsumed =
      totalBreakfastCalories +
      totalLunchCalories +
      totalDinnerCalories +
      totalSnacksCalories;

    caloriesRemaining =
      dailyCaloriesGoal - totalCaloriesConsumed + caloriesBurned;

    return await firestoreDatabase
      .collection("users")
      .doc(userId)
      .collection("foods")
      .doc(date)
      .update({
        dailyCaloriesGoal: dailyCaloriesGoal,
        totalCaloriesConsumed: totalCaloriesConsumed,
        caloriesBurned: caloriesBurned,
        caloriesRemaining: caloriesRemaining,
        totalBreakfastCalories: totalBreakfastCalories,
        totalLunchCalories: totalLunchCalories,
        totalDinnerCalories: totalDinnerCalories,
        totalSnacksCalories: totalSnacksCalories,
      });
  });
