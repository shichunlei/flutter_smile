part of charts;

/// Customizes the selection in chart.
abstract class ChartSelectionBehavior {
  void onTouchDown(double xPos, double yPos);

  void onDoubleTap(double xPos, double yPos);

  void onLongPress(double xPos, double yPos);

  Paint getSelectedItemFill(Paint paint, int seriesIndex, int pointIndex,
      List<ChartSegment> selectedSegments);

  Paint getUnselectedItemFill(Paint paint, int seriesIndex, int pointIndex,
      List<ChartSegment> unselectedSegments);

  Paint getSelectedItemBorder(Paint paint, int seriesIndex, int pointIndex,
      List<ChartSegment> selectedSegments);

  Paint getUnselectedItemBorder(Paint paint, int seriesIndex, int pointIndex,
      List<ChartSegment> unselectedSegments);
}
