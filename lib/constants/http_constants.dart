// ********************* food **********************

const foodSearchEndPoint =
    'https://trackapi.nutritionix.com/v2/search/instant?';

const naturalNutrientsEndPoint =
    'https://trackapi.nutritionix.com/v2/natural/nutrients';

const searchItemEndPoint = 'https://trackapi.nutritionix.com/v2/search/item?';
const exerciseEndPoint = 'https://trackapi.nutritionix.com/v2/natural/exercise';

const appKey = '';
const appId = '';
const contentType = 'application/json';

const foodHeaders = {'x-app-id': appId, 'x-app-key': appKey};
const exerciseHeaders = {
  'x-app-id': appId,
  'x-app-key': appKey,
  'Content-Type': contentType
};

// ************************** recipes ************************

const searchRecipeEndPoint =
    'https://api.spoonacular.com/recipes/complexSearch?';
const recipeDetailsEndPoint = 'https://api.spoonacular.com/recipes/';
const recipeStepsEndPoint = 'https://api.spoonacular.com/recipes/';
const recipesApiKey = '';