// DateUtilsModule.groovy
import java.util.Date
import java.util.Calendar
import java.text.SimpleDateFormat

class DateUtilsModule{
    static def formatExpiryDate(dateString) {
        // Convert String -> Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        Date date = new Date(Long.parseLong(dateString))

        // Expire Day = Day + 3
        // Convert UTC+7 -> UTC = Hours - 7
        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.add(Calendar.DAY_OF_YEAR, 3)
        calendar.add(Calendar.HOUR_OF_DAY, -7)

        Date updatedDate = calendar.getTime()
        def formattedDate = sdf.format(updatedDate)
        return formattedDate
    }
}
