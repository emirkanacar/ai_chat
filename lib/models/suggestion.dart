class Suggestion {
  Suggestion({
    required this.dataType,
    required this.data,
  });

  final String? dataType;
  final List<SuggestionData> data;

  factory Suggestion.fromJson(Map<String, dynamic> json){
    return Suggestion(
      dataType: json["dataType"],
      data: json["data"] == null ? [] : List<SuggestionData>.from(json["data"]!.map((x) => SuggestionData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "dataType": dataType,
    "data": data.map((x) => x.toJson()).toList(),
  };

}

class SuggestionData {
  SuggestionData({
    required this.categoryCode,
    required this.categoryName,
    required this.prompts,
  });

  final String? categoryCode;
  final String? categoryName;
  final List<Prompt> prompts;

  factory SuggestionData.fromJson(Map<String, dynamic> json){
    return SuggestionData(
      categoryCode: json["categoryCode"],
      categoryName: json["categoryName"],
      prompts: json["prompts"] == null ? [] : List<Prompt>.from(json["prompts"]!.map((x) => Prompt.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "categoryCode": categoryCode,
    "categoryName": categoryName,
    "prompts": prompts.map((x) => x.toJson()).toList(),
  };

}

class Prompt {
  Prompt({
    required this.promptCode,
    required this.prompt,
    required this.promptLabel,
    required this.promptLabelTurkish,
    required this.promptTurkish
  });

  final String? promptCode;
  final String? promptLabel;
  final String? promptLabelTurkish;
  final String? prompt;
  final String? promptTurkish;

  factory Prompt.fromJson(Map<String, dynamic> json){
    return Prompt(
      promptCode: json["promptCode"],
      prompt: json["prompt"],
      promptLabel: json["promptLabel"],
      promptLabelTurkish: json["promptLabelTurkish"],
      promptTurkish: json["promptTurkish"]
    );
  }

  Map<String, dynamic> toJson() => {
    "promptCode": promptCode,
    "prompt": prompt,
    "promptLabel": promptLabel,
    "promptLabelTurkish": promptLabelTurkish,
    "promptTurkish": promptTurkish
  };

}
