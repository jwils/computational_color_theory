var questions = [];
var question = 1;
var answer_json = [];
var response_json = {};
var quiz_id;

function startQuiz() {
    closeInstructions();
    var rulerWidth = $("#ruler-width").val();
    var rulerHeight = $("#ruler-height").val();
    $("#survey_ruler_width").val($("#ruler-width").val());
    $("#survey_ruler_height").val($("#ruler-height").val());
    recordMeasurement(rulerWidth, rulerHeight);
}

function recordMeasurement(width, height) {
    measurements = {width: width, height: height};
    response_json['measurements'] = measurements;
}

function closeInstructions() {
    $("div#qHolder").show();
    $("div#instructions").hide();
    questions = $('#qHolder').data('questions');

    nextQuestion(questions[question -1].img1,
    questions[question -1].img2);
    //quiz_id = data['quiz_id']
}

function imgClick() {
    if ($("img.answer1").attr("disabled")) {
        return;
    }
    if ($(this).attr("class") == "answer1") {
        image = "img1"
    } else {
        image = "img2"
    }
    answer_json.push({ question_id : questions[question -1].id,
        chosen_image : image, d : questions[question -1].d});

    question = question + 1;
    if (question > questions.length) {
        response_json['answers'] = answer_json;
        response_json['quiz_id'] = quiz_id;
      //Submit results
      $("div#qHolder").hide();
      $("div#completion").show();
      $("button").hide();
      $("#survey_responses_raw").val(JSON.stringify(answer_json));
        return;
      } else {
        nextQuestion(questions[question -1].img1,
        questions[question -1].img2);
      }
}

  function prepareForNextQuestion() {
    $("div#mouseDiv").show();
  }

  function onMousePlace() {
    $("div#mouseDiv").hide();
    $("div#qHolder").fadeIn("slow", function() {
    $("img.answer1").attr("disabled", false);
    $("img.answer2").attr("disabled", false);
  });
  }

  function nextQuestion(image1, image2) {
    $("img.answer1").attr("disabled", true);
    $("img.answer2").attr("disabled", true);

    $("div#qHolder").fadeOut(1000, function(){
        $("img.answer1").attr("src",  String(image1.image_name));
        $("img.answer2").attr("src", String(image2.image_name));
        prepareForNextQuestion();
    });
  }
