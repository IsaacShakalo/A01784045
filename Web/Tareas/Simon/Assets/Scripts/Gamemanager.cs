using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class GameManager : MonoBehaviour
{
    // List of ints to keep track of tasks for our players
    private List<int> playerTaskList = new List<int>();
    private List<int> playerSequenceList = new List<int>();

    // Sound for when button gets clicked
    public List<AudioClip> buttonSoundList = new List<AudioClip>();

    // Colors for the buttons
    public List<List<Color32>> buttonColors = new List<List<Color32>>();

    // Reference to the clickable buttons
    public List<Button> clickableButtons;

    // Sound for losing
    public AudioClip loseSound;

    // Audio source for playing sounds
    public AudioSource audioSource;

    // Group of buttons to enable/disable interaction
    public CanvasGroup buttons;

    // Start button GameObject
    public GameObject startButton;

    // Text components for displaying score and high score
    public TMP_Text ScoreText;
    public TMP_Text HighScoreText;

    // Variables to keep track of the score and high score
    private int score = 0;
    private int highScore = 0;

    void Awake()
    {
        // Initialize colors for buttons
        buttonColors.Add(new List<Color32> { new Color32(255, 100, 100, 255), new Color32(255, 0, 0, 255) }); // Red
        buttonColors.Add(new List<Color32> { new Color32(255, 187, 109, 255), new Color32(255, 136, 0, 255) }); // Orange
        buttonColors.Add(new List<Color32> { new Color32(162, 255, 124, 255), new Color32(72, 248, 0, 255) }); // Green
        buttonColors.Add(new List<Color32> { new Color32(57, 111, 255, 255), new Color32(0, 70, 255, 255) }); // Blue
        
        for (int i = 0; i < clickableButtons.Count; i++)
        {
            clickableButtons[i].GetComponent<Image>().color = buttonColors[i][0];
        }

        // Load high score from PlayerPrefs
        highScore = PlayerPrefs.GetInt("HighScore", 0);
    }

    void Start()
    {
        // Initialize the displayed high score and score
        UpdateHighScoreText();
        UpdateScoreText(); // Make sure this is called to display the initial score
    }

    public void AddToPlayerSequenceList(int buttonId)
    {
        playerSequenceList.Add(buttonId);
        StartCoroutine(HighlightButton(buttonId));
        
        for (int i = 0; i < playerSequenceList.Count; i++)
        {
            if (playerTaskList[i] != playerSequenceList[i])
            {
                StartCoroutine(PlayerLost());
                return;
            }
        }
        
        if (playerSequenceList.Count == playerTaskList.Count)
        {
            StartCoroutine(StartNextRound());
        }
    }

    public void StartGame()
    {
        score = 0; // Reset score at the start of the game
        UpdateScoreText(); // Update the score display after resetting
        StartCoroutine(StartNextRound());
        startButton.SetActive(false);
    }

    public IEnumerator HighlightButton(int buttonId)
    {
        clickableButtons[buttonId].GetComponent<Image>().color = buttonColors[buttonId][1];
        audioSource.PlayOneShot(buttonSoundList[buttonId]);
        yield return new WaitForSeconds(0.5f);
        clickableButtons[buttonId].GetComponent<Image>().color = buttonColors[buttonId][0];
    }

    public IEnumerator PlayerLost()
    {
        audioSource.PlayOneShot(loseSound);
        playerSequenceList.Clear();
        playerTaskList.Clear();
        yield return new WaitForSeconds(2f);
        startButton.SetActive(true);

        // Check if current score is higher than high score
        if (score > highScore)
        {
            highScore = score;
            PlayerPrefs.SetInt("HighScore", highScore); // Save new high score
            PlayerPrefs.Save();
            UpdateHighScoreText(); // Update the displayed high score
        }
        score = 0; // Reset score after loss
        UpdateScoreText(); // Update score display
    }

    public IEnumerator StartNextRound()
    {
        score++; // Increment score each round
        UpdateScoreText(); // Update the score display after incrementing

        playerSequenceList.Clear();
        buttons.interactable = false;
        yield return new WaitForSeconds(1f);
        
        playerTaskList.Add(Random.Range(0, clickableButtons.Count));
        foreach (int index in playerTaskList)
        {
            yield return StartCoroutine(HighlightButton(index));
        }
        
        buttons.interactable = true;
    }

    // Method to update the displayed score
    void UpdateScoreText()
    {
        if (ScoreText != null)
        {
            ScoreText.text = "Level: " + score.ToString();
        }
    }

    // Method to update the displayed high score
    void UpdateHighScoreText()
    {
        if (HighScoreText != null)
        {
            HighScoreText.text = "High Score: " + highScore.ToString();
        }
    }
}