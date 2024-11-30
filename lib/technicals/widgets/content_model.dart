class UboardingContent {
  String image;
  String title;
  String description;
  UboardingContent(
      {required this.image, required this.title, required this.description});
}

List<UboardingContent> contents = [
  UboardingContent(
      image: "Images/fitsplash.png",
      title: 'Options to satisfy your \n       wellness needs.',
      description:
          '                              Select a trainer that fits your fitness goals, \n                                 a nutritionist to advice you on your diet\n  and a gym to thats convinient and available as per your standards. '),
  UboardingContent(
      image: "Images/foodnsup.png",
      title: 'Dietary options.',
      description:
          'Select foods and supplements within our menu that fit your dietary needs and goals, \n                                                            delivered to your doorstep.'),
  UboardingContent(
      image: "Images/equfit.png",
      title: 'Get equipment and gymwear.',
      description:
          '                     Select equipment that easens your fitness journey and \n stylish outfits that have you feeling good and comfortable while working out. \n                                                    Delivered to your doorstep.'),
];
