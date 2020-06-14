
import "Recipe.dart";

// Sample hardcoded data for testing purposes
List<Recipe> getRecipes() {
  return [
    Recipe(
      id: 0,
      name: "Blueberry Pancakes",
      type: RecipeType.main,
      rating: 4.9,
      duration: 45,
      servingSize: 2,
      imageURL: "assets/Recipe 0.jpg",
      ingredients: [
        "3/4 cup milk",
        "2 tablespoons white vinegar",
        "1 cup flour",
        "2 tablespoons sugar",
        "1 teaspoon baking powder",
        "1/2 teaspoon baking soda",
        "1 egg",
        "2 tablespoons melted butter",
        "1 cup fresh blueberries",
        "Butter",
      ],
      instructions: [
        "Mix the milk and vinegar and let it sit for 2 minutes",
        "Whisk the dry ingredients together. Whisk the egg, milk, and melted "
            "butter into the dry ingredients until just combined.",
        "Heat a nonstick pan over medium heat. Melt a little smear of butter in the pan",
        "Pour about 1/3 cup of batter into the hot skillet and spread it flat. "
            "Arrange a few blueberries on top. Cook until you see little bubbles "
            "on top and the edges starting to firm up. Flip and cook for another "
            "1-2 minutes until the pancakes are sky-high fluffy and cooked through."
      ],
    ),
    Recipe(
      id: 1,
      name: "Lemon Pancakes",
      type: RecipeType.main,
      rating: 4.7,
      duration: 45,
      servingSize: 2,
      imageURL: "assets/Recipe 1.jpg",
      ingredients: [
        "1 egg",
        "1 cup flour",
        "3 tablespoons sugar",
        "zest of 1 lemon",
        "1 teaspoon baking powder",
        "1/2 teaspoon baking soda",
        "1/2 teaspoon salt",
        "1 cup buttermilk",
        "2 tablespoons butter, melted and cooled slightly",
      ],
      instructions: [
        "In a small bowl, rub the lemon zest into the granulated sugar until fragrant.",
        "In a large bowl, whisk together the egg, buttermilk and butter. "
            "Add the flour, sugar, baking powder, baking soda and salt. "
            "Stir until just combined.",
        "Heat a nonstick griddle pan over medium heat. Add 1/4 cup of batter to the pan and cook a few minutes on both sides, "
            "until just lightly golden brown. Place cooked pancakes on an oven "
            "proof plate and let rest in a 200 degree oven while you fry the rest "
            "of the pancakes."
      ],
    ),
    Recipe(
      id: 2,
      name: "Butternut Squash Pecan Pancakes",
      type: RecipeType.main,
      rating: 4.8,
      duration: 30,
      servingSize: 2,
      imageURL: "assets/Recipe 2.jpg",
      ingredients: [
        "1 package Butternut Squash with Candied Cinnamon Sauce",
        "1 cup whole wheat white flour",
        "1 teaspoon baking soda",
        "1 teaspoon baking powder",
        "1/2 teaspoon salt",
        "1 teaspoon cinnamon",
        "1/2 teaspoon ginger",
        "2 tablespoons sugar",
        "2 eggs",
        "1/2 teaspoon vanilla",
        "1 tablespoon unsweetened applesauce",
        "1/4 cup chopped pecans",
        "1 tablespoon melted butter"
      ],
      instructions: [
        "Steam squash about 30 seconds longer than directed (for easy mashing), "
            "toss to coat with cinnamon sauce, and let cool slightly.",
        "Combine all dry ingredients in a small bowl. In a large bowl, mash about"
            " 2/3 of the squash. Add eggs, vanilla, applesauce, butter, and milk. "
            "Add dry ingredients and stir until just mixed.",
        "Pour a heaping 1/4 cup of batter onto a griddle or skillet at 300-350 "
            "degrees, or medium-high heat. When edges start to look dry, "
            "flip the pancakes and let cook another 2-3 minutes or until golden brown.",
        "Top with remaining squash, pecans, and maple syrup"
      ],
    ),
    Recipe(
      id: 3,
      name: "Cinnamon Roll Pancakes",
      type: RecipeType.main,
      rating: 4.9,
      duration: 45,
      servingSize: 2,
      imageURL: "assets/Recipe 3.jpg",
      ingredients: [
        "1 package Butternut Squash with Candied Cinnamon Sauce",
        "1 cup whole wheat white flour",
        "1 teaspoon baking soda",
        "1 teaspoon baking powder",
        "1/2 teaspoon salt",
        "2 tablespoons sugar",
        "2 egg whites",
        "2 teaspoons cinnamon",
        "1/2 teaspoon ginger",
        "1/4 cup light brown sugar",
        "1 tablespoon ground walnuts or bran",
        "1/2 cup Greek yogurt",
        "1 tablespoon honey"
      ],
      instructions: [
        "Mix the dry ingredients (flour through egg whites) until well-combined. "
            "Pour 1/4 cup batter on a medium-heat griddle and cook until bubbly; "
            "flip and cook again until light golden brown and cooked through.",
        "Stir together pumpkin, brown sugar, and cinnamon. Add ground walnuts "
            "or bran if the filling needs to be thicker. Place a in ziplock bag,"
            " snip the corner, and spiral filling on the tops of the pancakes.",
        "Whisk Greek yogurt and honey until smooth. Place in a ziplock bag, "
            "snip the corner, and drizzle over pancakes in a zigzag pattern. "
            "Top with additional walnuts."
      ],
    ),
    Recipe(
      id: 4,
      name: "Cinnamon Apple Carrot Pancakes",
      type: RecipeType.main,
      rating: 4.5,
      duration: 30,
      servingSize: 2,
      imageURL: "assets/Recipe 4.jpg",
      ingredients: [
        "1 3/4 cups raisin bran cereal",
        "1 1/4 cups all-purpose flour",
        "3/4 cup sugar",
        "1 1/4 teaspoons baking soda",
        "1 teaspoon ground cinnamon",
        "1/4 teaspoon salt",
        "1 egg",
        "3/4 cup buttermilk",
        "1/4 cup canola oil",
        "3/4 cup finely chopped peeled tart apple",
        "3/4 cup grated carrots",
      ],
      instructions: [
        "In a bowl, combine the first six ingredients. In a small bowl, beat the egg, "
            "buttermilk and oil. Stir into dry ingredients just until moistened. "
            "Fold in apple and carrots",
        "Pour 1/3 cup of batter onto a griddle on medium heat. Wait until the "
            "bottom side of the pancakes stick together enough to flip over. "
            "When pancakes have cooked through, remove and top with butter and maple syrup"
      ],
    ),
  ];
}