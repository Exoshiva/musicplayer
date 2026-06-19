class TimeUtils {
  // Der Private Konsruktor verhindert, dass diese Klasse jemals
  // mit new Timeutils() instanziiert wird
  TimeUtils._();

  /// Formatiert eine [Duration] in einen leeren String für den Musikplayer 
  static String formatDuration(Duration? duration) {
    if (duration == null) return '--:--'; // start mit leerem timestamp

    // Dieser String berechnet die Minuten die der geladene Song besitzt
    // und füllt sie bei bedarf mit einer 0 auf
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    String secondStr = seconds.toString().padLeft(2, '0');

    if (hours > 0) {

      String minutesStr = minutes.toString().padLeft(2, '0');
      String secondStr = seconds.toString().padLeft(2, '0');

      return '$hours:$minutesStr:$secondStr';
    } else {

      String minutesStr = minutes.toString().padLeft(2, '0');
      return '$minutesStr:$secondStr';
    }
  }
}